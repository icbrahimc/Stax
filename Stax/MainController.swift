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
}
