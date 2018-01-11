//
//  LaunchViewController.swift
//  Stax
//
//  Created by icbrahimc on 1/10/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import UIKit

/* This class is to help load all relevant data before the viewcontrollers are instatiated */
class LaunchViewController: UIViewController {
    
    lazy var mainController: MainController = {
        return MainController()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        ProfileManager.sharedInstance.fetchUserInfo { (userInfo) in
            ProfileManager.sharedInstance.user = userInfo
            self.loadVC()
        }
    }
    
    func loadVC() {
        UIApplication.shared.keyWindow?.rootViewController = mainController.mainViewController
    }
}
