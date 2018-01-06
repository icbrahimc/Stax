//
//  MainController.swift
//  Stax
//
//  Created by icbrahimc on 12/25/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Firebase
import UIKit

class MainController: NSObject, UITabBarControllerDelegate {
    let mainTabVC: MainTabBarController = MainTabBarController()
    
    fileprivate var didInitializeWithToken: Bool = false
    fileprivate var selectedViewController: UIViewController?
    fileprivate var apiObserver: AnyObject?
    fileprivate var signoutObserver: AnyObject?
    
    fileprivate lazy var welcomeViewController: UINavigationController = {
        NotificationCenter.default.addObserver(self, selector: #selector(MainController.dismissLoginFlow), name: NSNotification.Name(rawValue: "onboardingEnded"), object: nil)
        return OnboardingNavigationController()
    }()
    
    var mainViewController: UIViewController {
        if ProfileManager.sharedInstance.user?.username != "" {
            setup()
            return mainTabVC
        }
        
        return welcomeViewController
    }
    
    fileprivate func setup() {
        self.mainTabVC.selectedIndex = 0

        mainTabVC.delegate = self
    }
    
    //MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let nav = viewController as? UINavigationController else {
            return
        }
        
        let root: UIViewController = nav.viewControllers[0]
        if tabBarController.selectedViewController == nav {
            selectedViewController = root
        }
    }
    
    func activateLogin() {
        mainTabVC.present(welcomeViewController, animated: true, completion: nil)
    }
    
    @objc func dismissLoginFlow() {
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        welcomeViewController.popToRootViewController(animated: false)
        
        if !didInitializeWithToken {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            UIApplication.shared.keyWindow?.rootViewController = appDelegate.mainController.mainViewController
        } else {
            welcomeViewController.dismiss(animated: true, completion: nil)
        }
    }
}
