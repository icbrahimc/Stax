//
//  ProfileManager.swift
//  Stax
//
//  Created by icbrahimc on 12/26/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import PromiseKit
import UIKit

let UserInfoUpdated = "UserInfoUpdated"

class ProfileManager: NSObject {
    var user: User?
    static let sharedInstance = ProfileManager(api: BaseAPI.sharedInstance)
    
    fileprivate let api: BaseAPI
    
    init(api: BaseAPI) {
        self.api = api
        self.user = User(username: "", id: "", favoritedPlaylists: NSMutableArray())
    }
    
    /* Fetch the user's info */
    func fetchUserInfo(_ completion: @escaping (User) -> ()) {
        var userInfo: User = User()
        api.loadUserInfo({ (userData) in
            if let username = userData["username"] as? String {
                userInfo.username = username
            }
            
            if let id = userData["id"] as? String {
                userInfo.id = id
            }
            
            if let playlist = userData["favoritedPlaylists"] as? NSMutableArray {
                userInfo.favoritedPlaylists = playlist
            }
            completion(userInfo)
        })
    }
    
    /* Return if the user has a username */
    func userHasUsername() -> Bool {
        if user?.username != nil && user?.username != "" {
            return true
        }
        return false
    }
    
    /* Check if the username exists in the database */
    func usernameExistsInDB(_ username: String, completion: @escaping (Bool) -> ()) {
        api.db.collection("usernames").document(username).getDocument { (document, error) in
            if let err = error {
                print("usernameExistInDb error: \(err.localizedDescription)")
                completion(false)
                return
            } else {
                if (document?.exists)! {
                    completion(true)
                    return
                }
                completion(false)
            }
        }
    }
    
    /* Create new user flag */
    func userExistsInDB(_ uid: String, completion: @escaping (Bool, Bool) -> ()) {
        var userBool: Bool = false
        var usernameBool: Bool = false
        api.db.collection("users").document(uid).getDocument(completion: { (document, error) in
            if let err = error {
                print("userExistInDb error: \(err.localizedDescription)")
                completion(userBool, usernameBool)
            } else {
                userBool = true
                guard let _ = document!["username"] else {
                    usernameBool = false
                    print("Username does not exist")
                    completion(userBool, usernameBool)
                    return
                }
                usernameBool = true
                completion(userBool, usernameBool)
            }
        })
    }
}
