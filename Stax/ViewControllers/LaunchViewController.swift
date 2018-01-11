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

        ProfileManager.sharedInstance.fetchUserInfo { (userInfo) in
            ProfileManager.sharedInstance.user = userInfo
            if ProfileManager.sharedInstance.userHasUsername() {
                self.loadVC()
            }
        }
    }
    
    func loadVC() {
        self.navigationController?.present(mainController.mainViewController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
