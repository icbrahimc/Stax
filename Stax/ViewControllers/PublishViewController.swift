//
//  PublishViewController.swift
//  Stax
//
//  Created by icbrahimc on 2/25/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

private let reuseIdentifier = "Cell"

class PublishViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var playlistToPublish: Playlist?
    var tracks: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        title = "Publish"
        
        // Register cell classes
        self.collectionView!.register(TrackViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(PublishReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(submitPlaylist))
        
        collectionView?.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func submitPlaylist() {
        let alert = UIAlertController(title: "Publish Playlist?", message: "Would you like to publish \(playlistToPublish?.title)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Yes", style: .default) { (submit) in
            BaseAPI.sharedInstance.addPlaylist(self.playlistToPublish!, completionBlock: { (documentID) in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewPlaylist"), object: nil)
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
        
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        self.navigationController?.present(alert, animated: true, completion: nil)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tracks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TrackViewCell
    
        if tracks.count != 0 {
            cell.track = tracks[indexPath.row]
        }
        
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height * 0.07)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! PublishReusableView
            headerView.playlist = playlistToPublish
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height * 0.2)
    }
}
