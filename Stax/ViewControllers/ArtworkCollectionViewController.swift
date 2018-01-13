//
//  ArtworkCollectionViewController.swift
//  Stax
//
//  Created by icbrahimc on 12/18/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import FirebaseFirestore
import UIKit

private let artworkIdentifier = "Cell"

class ArtworkCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var cellSpacing: CGFloat = 10
    
    var playlists = [Playlist]()
    
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

        title = "Discovery"
        collectionView?.backgroundColor = UIColor.init(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 1.0)
        
        // Register cell classes
        self.collectionView!.register(ArtworkCollectionViewCell.self, forCellWithReuseIdentifier: artworkIdentifier)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.reloadData()
        collectionView?.addSubview(refreshControl)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addNewPlaylists))
        fetchPlaylists()
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

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return playlists.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: artworkIdentifier, for: indexPath) as! ArtworkCollectionViewCell
        let playlist = playlists[indexPath.row]
        cell.playlist = playlist
//        if let title = playlist.title {
//            cell.titleLabel.text = title
//        }
//
//        if let creatorUsername = playlist.creatorUsername {
//            cell.creatorLabel.text = "Curated by: \(creatorUsername)"
//        }
//
//        if let imageURL = playlist.coverArtLink {
//            cell.imageView.loadImageUsingCacheWithUrlString(imageURL)
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height * 0.8
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, cellSpacing, 0, cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    /* Handle refresh */
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        // TODO (icbrahimc): Add handle refresh code when the api is connected.
        refreshControl.endRefreshing()
    }
    
    @objc func addNewPlaylists() {
        let newVC = AddPlaylistViewController()
        let navVC = UINavigationController(rootViewController: newVC)
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
}
