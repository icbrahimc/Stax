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
        self.tabBar.tintColor = .black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setup() {
        let navVCArtwork = UINavigationController(rootViewController: artworkVC)
        navVCArtwork.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "feed"), tag: 1)
        navVCArtwork.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        navVCArtwork.isNavigationBarHidden = true
        
        let navVCSave = UINavigationController(rootViewController: SavedViewController())
        navVCSave.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "saveTab"), tag: 2)
        navVCSave.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        navVCSave.isNavigationBarHidden = true
        
        let navVCSearch = UINavigationController(rootViewController: SearchViewController())
        navVCSearch.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "search"), tag: 3)
        navVCSearch.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        navVCSearch.isNavigationBarHidden = true
        
        let navVCAddPlaylist = UINavigationController(rootViewController: NotificationsViewController())
        navVCAddPlaylist.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "notifications"), tag: 4)
        navVCAddPlaylist.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        navVCAddPlaylist.isNavigationBarHidden = true
        
        let navVCProf = UINavigationController(rootViewController: profileVC)
        navVCProf.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "person"), tag: 5)
        navVCProf.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        navVCProf.isNavigationBarHidden = true
        
        viewControllers = [navVCArtwork, navVCSave, navVCSearch, navVCAddPlaylist, navVCProf]
    }
}
