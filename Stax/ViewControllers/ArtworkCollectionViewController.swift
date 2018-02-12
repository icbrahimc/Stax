//
//  ArtworkCollectionViewController.swift
//  Stax
//
//  Created by icbrahimc on 12/18/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Alamofire
import FirebaseFirestore
import SwiftyJSON
import UIKit

private let reuseIdentifier = "Cell"
private let addIdentifier = "AddCell"
private let artworkIdentifier = "ArtworkCell"

class ArtworkCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var cellSpacing: CGFloat = 25
    
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
        
        navigationController?.navigationBar.isHidden = true
        
//        fetchPlaylists()
    }
    
    /////////////////* Custom Methods */////////////////
    
    /* Handle refresh */
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        // TODO (icbrahimc): Add handle refresh code when the api is connected.
        refreshControl.endRefreshing()
    }

    /* Fetch users playlist */
    func fetchPlaylists() {
        BaseAPI.sharedInstance.db.collection("playlists").addSnapshotListener({ (querySnapshot, error) in
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
//            return CGSize(width: self.view.frame.width, height: self.view.frame.height * 0.25)
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
            if playlists.count != 0 {
                return playlists.count
            }
            return 10
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
            
//            let playlist = playlists[indexPath.row]
//            cell.playlist = playlist
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: view.frame.width, height: 75)
            
        case 1:
            let width = (UIScreen.main.bounds.size.width - 3 * cellSpacing) / 2
            let height = width + 90
            
            print("Width \(width)")
            print("Length \(height)")
            
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
