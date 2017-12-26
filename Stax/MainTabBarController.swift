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
        navVCArtwork.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        
        let navVCProf = UINavigationController(rootViewController: profileVC)
        navVCProf.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        viewControllers = [navVCArtwork, navVCProf]
    }
}
