//
//  OnboardingViewController.swift
//  Stax
//
//  Created by icbrahimc on 1/10/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(segueToUsernameVC), name: NSNotification.Name(rawValue: "Login"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(segueToMainVC), name: NSNotification.Name(rawValue: "FullLogin"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    /* Handle facebook login */
    @objc func facebookSignIn() {
        print("Facebook")
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self, handler: {
            (result, err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            // Get the access token and authenticate.
            let accessToken = FBSDKAccessToken.current()
            guard let accessTokenString = accessToken?.tokenString else {
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let uid = user?.uid else {
                    // TODO(icbrahimc): Properly handle this error in the future.
                    print("User id is not retrievable")
                    return
                }
                
                print("Successfully Logged into firebase with Facebook")
                ProfileManager.sharedInstance.fetchUserInfo({ (userInfo) in
                    ProfileManager.sharedInstance.user = userInfo
                    guard let _ = ProfileManager.sharedInstance.user?.id else {
                        BaseAPI.sharedInstance.createNewUser(uid)
                        ProfileManager.sharedInstance.user?.id = uid
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Login"), object: nil)
                        return
                    }
                    
                    if (ProfileManager.sharedInstance.userHasUsername()) {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FullLogin"), object: nil)
                    } else {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Login"), object: nil)
                    }
                })
            }
        })
    }

    /* Handle google login */
    @objc func googleSignIn() {
        print("Google")
        GIDSignIn.sharedInstance().signIn()
    }
    
    /* Segue to assist with onboarding vc. */
    @objc func segueToUsernameVC() {
        if let navVC = navigationController as? OnboardingNavigationController {
            navVC.statisfyRequirement(.signIn)
            navVC.pushNextPhase()
        }
    }
    
    /* Segue to assist with onboarding vc. */
    @objc func segueToMainVC() {
        if let navVC = navigationController as? OnboardingNavigationController {
            navVC.statisfyRequirement(.signIn)
            navVC.statisfyRequirement(.username)
            navVC.pushNextPhase()
        }
    }
}
