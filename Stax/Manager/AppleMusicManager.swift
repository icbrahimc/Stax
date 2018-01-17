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
            return
            
        case .denied:
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
            print("The user has selected 'Don't Allow' in the past - so we're going to show them a different dialog to push them through to their Settings page and change their mind, and exit the function early.")
            
            // Show an alert to guide users into the Settings
            
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
                
            case .denied:
                
                print("The user tapped 'Don't allow'. Read on about that below...")
                
            case .notDetermined:
                
                print("The user hasn't decided or it's not clear whether they've confirmed or denied.")
                
            default: break
                
            }
            
        }
        
    }
}
