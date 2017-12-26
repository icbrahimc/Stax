//
//  MainController.swift
//  Stax
//
//  Created by icbrahimc on 12/25/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

class MainController: NSObject, UITabBarControllerDelegate {
    let mainTabVC: UITabBarController = UITabBarController()
    
    fileprivate var didInitializeWithToken: Bool = false
    fileprivate var selectedViewController: UIViewController?
    fileprivate var apiObserver: AnyObject?
    fileprivate var signoutObserver: AnyObject?
    
//    fileprivate lazy var welcomeViewController: UINavigationController = {
//        NotificationCenter.default.addObserver(self, selector: #selector(MainController.dismissLoginFlow), name: NSNotification.Name(rawValue: "onboardingEnded"), object: nil)
//        return EnrollNavigationController()
//    }()
    
    var mainViewController: UIViewController {
//        didInitializeWithToken = AuthorizationManager.sharedInstance.hasAccessToken()
        if didInitializeWithToken {
            return mainTabVC
        }
        
        return WelcomeViewController()
    }
    
    fileprivate func setup() {
        self.mainTabVC.selectedIndex = 0
        mainTabVC.delegate = self
    }
    
    //MARK: - UITabBarControllerDelegate
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        guard let nav = viewController as? UINavigationController else {
//            return
//        }
//        
//        let root: UIViewController = nav.viewControllers[0]
//        if selectedViewController == root {
//            if let homeVC = selectedViewController as? HomeViewController {
//                homeVC.scrollToTop()
//            } else if let discoverVC = root as? DiscoverViewController {
//                discoverVC.scrollCurrentViewToTop()
//            } else if let alertsVC = root as? AlertsTableViewController {
//                alertsVC.tableView.setContentOffset(CGPoint.zero, animated: true)
//            } else if let profileVC = root as? ProfileViewController, profileVC.collectionView != nil {
//                profileVC.collectionView?.setContentOffset(CGPoint(x: 0, y: -profileVC.collectionView.contentInset.top), animated: true)
//            }
//        }
//        if tabBarController.selectedViewController == nav {
//            selectedViewController = root
//        }
//    }
}
