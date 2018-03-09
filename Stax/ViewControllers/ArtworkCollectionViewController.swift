//
//  ArtworkCollectionViewController.swift
//  Stax
//
//  Created by icbrahimc on 12/18/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Alamofire
import FirebaseFirestore
import SpotifyLogin
import SwiftyJSON
import UIKit

private let reuseIdentifier = "Cell"
private let addIdentifier = "AddCell"
private let artworkIdentifier = "ArtworkCell"

class ArtworkCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var cellSpacing: CGFloat = 35
    
    /* Playlist array */
    var playlists = [Playlist]()
    
    /* Refresh control variable. Handles pull to refresh capabilities */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ArtworkCollectionViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
        
        // Register cell classes
        self.collectionView!.register(ArtworkCollectionViewCell.self, forCellWithReuseIdentifier: artworkIdentifier)
        self.collectionView!.register(AddPlaylistCell.self, forCellWithReuseIdentifier: addIdentifier)
        self.collectionView!.register(FeedReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.reloadData()
        collectionView?.addSubview(refreshControl)
        
        setupNotifications()
        fetchPlaylists {
            print("Fetch initial playlists!")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    /* Setup notifications */
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didTapSpotifyBtn), name: NSNotification.Name(rawValue: "TapSpotifyButton"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didTapAppleBtn), name: NSNotification.Name(rawValue: "TapAppleButton"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshPlaylists), name: NSNotification.Name(rawValue: "NewPlaylist"), object: nil)
    }
    
    /* Handle the tap apple button action. Pass on playlist information to the publishvc. */
    @objc func didTapAppleBtn() {
        let alert = UIAlertController(title: "Apple Music Link", message: "Please enter your playlist share link", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Add Apple Music Link"
        }
        
        let actionOne = UIAlertAction(title: "Retrieve Playlist", style: .default) { (action) in
            // Instantiate a new playlist to pass on to the next vc.
            var appleMusicPlaylist: Playlist = Playlist()
            
            let textField = alert.textFields![0] as UITextField
            
            if let linkText = textField.text {
                // Parse the linkText for the URLS.
                let linkParams = parseAppleLink(linkText)
                
                let storeFront = linkParams[0]
                let id = linkParams[1]
                
                let apiCall = "https://api.music.apple.com/v1/catalog/\(storeFront)/playlists/\(id)"
                
                let url = URL(string: apiCall)
                let headers: HTTPHeaders = [
                    "Authorization" : "Bearer \(Constants.APPLE)"
                ]
                
                appleMusicPlaylist.appleLink = linkText
                
                // Make the request.
                Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).validate().responseJSON { (data) in
                    
                    guard let response = data.data else {
                        print("Error no data present")
                        return
                    }
                    
                    if let err = data.error {
                        print(err.localizedDescription)
                        return
                    }
                    
                    // Parse JSON data.
                    let appleJSON = JSON(response)
                    
                    let data = appleJSON["data"][0]
                    let attributes = data["attributes"]
                    
                    // Add data to the playlist object.
                    if let imageURL = attributes["artwork"]["url"].string {
                        let height = attributes["artwork"]["height"].stringValue
                        let width = attributes["artwork"]["width"].stringValue
                        
                        var finalImageURL = imageURL.replacingOccurrences(of: "{w}", with: width)
                        finalImageURL = finalImageURL.replacingOccurrences(of: "{h}", with: height)
                        
                        appleMusicPlaylist.coverArtLink = finalImageURL
                    }
                    
                    if let name = attributes["name"].string {
                        appleMusicPlaylist.title = name
                    }
                    
                    appleMusicPlaylist.creatorUsername = ProfileManager.sharedInstance.user?.username
                    
                    var songs: [Song] = []
                    let tracks = data["relationships"]["tracks"]["data"]
                    for track in tracks.arrayValue {
                        var song = Song()
                        let trackAttr = track["attributes"]
                        
                        song.artistName = trackAttr["artistName"].stringValue
                        song.albumName = trackAttr["albumName"].stringValue
                        song.sharingURL = trackAttr["url"].stringValue
                        songs.append(song)
                    }
                    
                    // Pass the playlist to the next vc.
                    let vc = PublishViewController(collectionViewLayout: UICollectionViewFlowLayout())
                    vc.playlistToPublish = appleMusicPlaylist
                    vc.tracks = songs
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        
        let actionTwo = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(actionOne)
        alert.addAction(actionTwo)
        
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    /* Handle the tap spotify button action. Go on to the spotifyVC. */
    @objc func didTapSpotifyBtn() {
        print("Open spotify client")
        SpotifyLogin.shared.getAccessToken(completion: { (token, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            
            guard let token = token else {
                SpotifyLoginPresenter.login(from: self, scopes: [.playlistReadPrivate, .playlistReadCollaborative])
                return
            }
            
            ProfileManager.sharedInstance.spotifyMusicID = token
            ProfileManager.sharedInstance.spotifyUsername = SpotifyLogin.shared.username!
            
            let alert = UIAlertController(title: "Spotify", message: "Are you \(ProfileManager.sharedInstance.spotifyUsername)", preferredStyle: UIAlertControllerStyle.alert)
            
            let alertActionOne = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
                let newVC = SpotifyViewController()
                let navVC = UINavigationController(rootViewController: newVC)
                self.navigationController?.present(navVC, animated: true, completion: nil)
            })
            
            let alertActionTwo = UIAlertAction(title: "No, Sign Out", style: UIAlertActionStyle.cancel, handler: { (alert) in
                SpotifyLogin.shared.logout()
            })
            
            alert.addAction(alertActionOne)
            alert.addAction(alertActionTwo)
            
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    /////////////////* Custom Methods */////////////////
    
    /* Handle refresh */
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        // TODO (icbrahimc): Add handle refresh code when the api is connected.
        fetchPlaylists {
            refreshControl.endRefreshing()
        }
    }
    
    @objc func refreshPlaylists() {
        playlists.removeAll()
        fetchPlaylists {
            print("Refreshed playlists")
        }
    }

    /* Fetch users playlist */
    @objc func fetchPlaylists(_ completion: @escaping () -> ()) {
        let playlistRef = BaseAPI.sharedInstance.db.collection("playlists").limit(to: 5)
        
        playlistRef.addSnapshotListener({ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            for document in documents {
                let id = document["id"] as? String
                let title = document["title"] as? String
                let description = document["description"] as? String
                let creatorUsername = document["creatorUsername"] as? String
                let appleLink = document["appleMusicLink"] as? String
                let spotifyLink = document["spotifyMusicLink"] as? String
                let youtubeLink = document["youtubeLink"] as? String
                let cloudLink = document["soundcloudLink"] as? String
                let coverartLink = document["coverartLink"] as? String
                let likes = document["likes"] as? NSDictionary
                

                let appendPlaylist = Playlist(id: id ?? "", title: title ?? "", description: description ?? "", creatorUsername: creatorUsername ?? "", spotifyLink: spotifyLink ?? "", appleLink: appleLink ?? "", cloudLink: cloudLink ?? "", youtubeLink: youtubeLink ?? "", coverArtLink: coverartLink ?? "", likes: likes?.allKeys as? NSMutableArray ?? NSMutableArray())
                self.playlists.append(appendPlaylist)
            }
        })
        
        DispatchQueue.main.async(execute: {
            self.collectionView?.reloadData()
            completion()
        })
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! FeedReusableView
            
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: self.view.frame.width, height: 100)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section {
        case 0:
            return 1
        case 1:
            return playlists.count
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addIdentifier, for: indexPath) as! AddPlaylistCell
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: artworkIdentifier, for: indexPath) as! ArtworkCollectionViewCell
            
            let playlist = playlists[indexPath.row]
            cell.playlist = playlist
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let playlistVC = PlaylistViewController(collectionViewLayout: UICollectionViewFlowLayout())
            playlistVC.playlist = playlists[indexPath.row]
            self.navigationController?.pushViewController(playlistVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: view.frame.width, height: 70)
            
        case 1:
            let width = (UIScreen.main.bounds.size.width - 3 * cellSpacing) / 2
            let height = width + 130
            
            return CGSize(width: width, height: height)
            
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
            
        case 0:
            return UIEdgeInsetsMake(0, 0, 0, 0)
            
        case 1:
            return UIEdgeInsetsMake(0, cellSpacing, 0, cellSpacing)
            
        default:
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
