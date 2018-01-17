//
//  MainTabBarController.swift
//  Stax
//
//  Created by icbrahimc on 12/25/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    fileprivate lazy var artworkVC: UICollectionViewController = {
        let artworkLayout = UICollectionViewFlowLayout()
        let artworkVC = ArtworkCollectionViewController(collectionViewLayout: artworkLayout)
        return artworkVC
    }()
    
    fileprivate lazy var addPlaylistVC: UIViewController = {
        let vc = AddPlaylistViewController()
        return vc
    }()
    
    fileprivate lazy var profileVC: UICollectionViewController = {
        let profileLayout = UICollectionViewFlowLayout()
        let profileVC = ProfileViewController(collectionViewLayout: profileLayout)
        return profileVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setup() {
        let navVCArtwork = UINavigationController(rootViewController: artworkVC)
        navVCArtwork.tabBarItem =  UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), tag: 1)
        
        let navVCAddPlaylist = UINavigationController(rootViewController: addPlaylistVC)
        navVCAddPlaylist.tabBarItem = UITabBarItem(title: "Add Playlist", image: #imageLiteral(resourceName: "add"), tag: 2)
        
        let navVCProf = UINavigationController(rootViewController: profileVC)
        navVCProf.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "person"), tag: 3)
        
        viewControllers = [navVCArtwork, navVCAddPlaylist, navVCProf]
    }
}
