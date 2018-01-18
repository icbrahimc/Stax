//
//  AppleMusicManager.swift
//  Stax
//
//  Created by icbrahimc on 1/17/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import MediaPlayer
import StoreKit
import UIKit

class AppleMusicManager: NSObject {
    static let sharedInstance = AppleMusicManager()
    
    // Request permission from the user to access the Apple Music library
    func appleMusicRequestPermission(_ viewController: UIViewController, completion: @escaping (Bool) -> ()) {
        
        switch SKCloudServiceController.authorizationStatus() {
            
        case .authorized:
            print("The user's already authorized - we don't need to do anything more here, so we'll exit early.")
            let alert = UIAlertController(title: "Apple Music Already Authorized", message: "Enjoy posting playlists!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            viewController.present(alert, animated: true, completion: nil)
            completion(true)
            return
            
        case .denied:
            print("The user has selected 'Don't Allow' in the past - so we're going to show them a different dialog to push them through to their Settings page and change their mind, and exit the function early.")
            let alert = UIAlertController(title: "Give Apple Music Permission", message: "In order to pull your Apple Music Playlists, please go into your settings and authorize Apple Music", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { (action) in
                guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(settingsAction)
            alert.addAction(cancelAction)
            viewController.present(alert, animated: true, completion: nil)
            return
            
        case .notDetermined:
            
            print("The user hasn't decided yet - so we'll break out of the switch and ask them.")
            break
            
        case .restricted:
            
            print("User may be restricted; for example, if the device is in Education mode, it limits external Apple Music usage. This is similar behaviour to Denied.")
            return
        }
        
        SKCloudServiceController.requestAuthorization { (status:SKCloudServiceAuthorizationStatus) in
            
            switch status {
                
            case .authorized:
                print("All good - the user tapped 'OK', so you're clear to move forward and start playing.")
                completion(true)
                
            case .denied:
                
                print("The user tapped 'Don't allow'. Read on about that below...")
                
            case .notDetermined:
                
                print("The user hasn't decided or it's not clear whether they've confirmed or denied.")
                
            default: break
                
            }
        }
    }
    
    // Fetch the user's storefront ID
    func appleMusicFetchUserToken(_ completion: @escaping (String) -> ()) {
        let serviceController = SKCloudServiceController()
        if #available(iOS 11.0, *) {
            serviceController.requestUserToken(forDeveloperToken: Constants.APPLE) { (userToken, err) in
                guard err == nil else {
                    print("An error occured. Handle it here.")
                    completion("")
                    return
                }
                
                guard let userID = userToken else {
                    print("Handle the error - the callback didn't contain a valid user id.")
                    completion("")
                    return
                }
                
                completion(userID)
            }
        } else {
            // Fallback on earlier versions
            if #available(iOS 10.3, *) {
                serviceController.requestPersonalizationToken(forClientToken: Constants.APPLE, withCompletionHandler: { (userToken, err) in
                    guard err == nil else {
                        print("An error occured. Handle it here.")
                        completion("")
                        return
                    }
                    
                    guard let userID = userToken else {
                        print("Handle the error - the callback didn't contain a valid user id.")
                        completion("")
                        return
                    }
                    
                    completion(userID)
                })
            } else {
                // Fallback on earlier versions
                print("cannot fetch user tokens")
            }
        }
    }
    
    func appleMusicFetchStorefrontRegion(_ completion: @escaping (String) -> ()) {
        let serviceController = SKCloudServiceController()
        serviceController.requestStorefrontIdentifier { (storefrontId:String?, err: Error?) in
            guard err == nil else {
                print("An error occured. Handle it here.")
                return
            }
            
            guard let storefrontID = storefrontId, storefrontID.count >= 6 else {
                print("Handle the error - the callback didn't contain a valid storefrontID.")
                return
            }
            
            let index = storefrontID.index(storefrontID.startIndex, offsetBy: 6)
            let trimmedId = storefrontID[..<index]
            
            print("Success! The user's storefront ID is: \(trimmedId)")
            completion(String(trimmedId))
        }
    }
}
