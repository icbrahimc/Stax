//
//  AppDelegate.swift
//  Stax
//
//  Created by icbrahimc on 12/5/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import GoogleSignIn
import PureLayout
import StoreKit
import MediaPlayer
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, SPTAudioStreamingDelegate {

    var window: UIWindow?
    
    var auth = SPTAuth()
    
    lazy var mainController: MainController = {
        return MainController()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Firebase config.
        FirebaseApp.configure()

        
        // FBSDK config.
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        var configureError: NSError?
//        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        setupSpotify()
        
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//            GIDSignIn.sharedInstance().signOut()
//            let loginManager = FBSDKLoginManager()
//            loginManager.logOut() // this is an instance function
//            NotificationCenter.default.post(name: Notification.Name(rawValue: "SignoutNotification"), object: nil)
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
        
        auth.redirectURL = URL(string: "Stax://")
        auth.sessionUserDefaultsKey = "current session"
//        self.auth = SPTAuth.defaultInstance()
//        self.player = SPTAudioStreamingController.sharedInstance()
//        self.auth.clientID = "909d311de7ff4b9b84252482d9931598"
//        self.auth.redirectURL = URL(string: "Stax://returnAfterLogin")
//        self.auth.sessionUserDefaultsKey = "current session"
//
//        self.auth.requestedScopes = [SPTAuthStreamingScope]
//
//        DispatchQueue.main.async(execute: {
//            self.auth.
//        })
        
//        let playlist = Playlist(id: "123", title: "yuh", description: "j", creatorUsername: "jnj", spotifyLink: "jnjj", appleLink: "bhj", cloudLink: "bhgbj", youtubeLink: "bhhb", coverArtLink: "hb", likes: NSMutableArray())
//        let user = User(username: "icbrahim", id: "456", favoritedPlaylists: NSMutableArray())
//        
//        BaseAPI.sharedInstance.comment(user, playlist: playlist, commentText: "Conteh") { (streets) in
//            print(streets)
//        }

        // The main view controller for the application.
        window = UIWindow(frame: UIScreen.main.bounds)
//        window!.rootViewController = UINavigationController(rootViewController: LaunchViewController())
        window!.rootViewController = UINavigationController(rootViewController: SettingsViewController())
        window?.makeKeyAndVisible()
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let urlString = url.absoluteString
        if urlString.range(of: "com.facebook.sdk") != nil {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                                                                         open: url,
                                                                         sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                                         annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        }
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let urlString = url.absoluteString
        if urlString.range(of: "com.facebook.sdk") != nil {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                                                                         open: url,
                                                                         sourceApplication: sourceApplication,
                                                                         annotation: annotation)
        }
        
        // Spotify Auth
        if auth.canHandle(auth.redirectURL) {
            auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (err, session) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                let userDefaults = UserDefaults.standard
                
                let sessionData = NSKeyedArchiver.archivedData(withRootObject: session)
                
                userDefaults.set(sessionData, forKey: "SpotifySession")
                
                userDefaults.synchronize()
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "loginSuccessfull"), object: nil)
            })
            
            return true
        }
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        SKCloudServiceController.requestAuthorization { (status) in
//            if status == .authorized {
//                let controller = SKCloudServiceController()
//                //Check if user is a Apple Music member
//                controller.requestCapabilities(completionHandler: { (capabilities, error) in
//                    if error != nil {
////                        dispatch_async(dispatch_get_main_queue(), {
////                            self.showAlert("Capabilites error", error: "You must be an Apple Music member to use this application")
////                        })
//                        print("FUCK")
//                    }
//                })
//            } else {
////                dispatch_async(dispatch_get_main_queue(), {
////                    self.showAlert("Denied", error: "User has denied access to Apple Music library")
////                })
//                print("No")
//            }
//        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print("Failed to log in Google", error)
            return
        }
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let err = error{
                print("Failed to Firebase user with Google account", err)
            }
            guard let uid = user?.uid else {
                return
            }
            
            print("Successfully Logged into firebase with Google")
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
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Logout from Google")
    }

    func setupSpotify() {
        SPTAuth.defaultInstance().clientID = Constants.SPOTCLIENTID
        SPTAuth.defaultInstance().redirectURL = Constants.SPOTURL
        SPTAuth.defaultInstance().sessionUserDefaultsKey = Constants.SPOTSESSION
        
        SPTAuth.defaultInstance().requestedScopes = [
            SPTAuthPlaylistReadPrivateScope,
            SPTAuthPlaylistModifyPublicScope,
            SPTAuthPlaylistModifyPrivateScope
        ]
    }
}

