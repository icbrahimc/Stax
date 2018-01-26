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
    /* The overarching user model */
    var user: User?
    
    static let sharedInstance = ProfileManager(api: BaseAPI.sharedInstance)
    
    fileprivate let api: BaseAPI
    
    /* Default init */
    init(api: BaseAPI) {
        self.api = api
        self.user = User(username: "", id: "", favoritedPlaylists: NSMutableArray())
    }
    
    /* Like ids associated with this particular user */
    var likeIds: Set<String> = Set()
    
    /* Apple music id associated with the user */
    var appleMusicID: String = ""
    
    /* Clear user info */
    func clearUserInfo(_ completion: @escaping () -> ()) {
        user?.id = ""
        user?.username = ""
        user?.favoritedPlaylists = NSMutableArray()
        likeIds = Set()
        completion()
    }
    
    /* Fetch the user's info */
    func fetchUserInfo(_ completion: @escaping (User) -> ()) {
        var userInfo: User = User()
        api.loadUserInfo({ (userData) in
            if let username = userData["username"] as? String {
                userInfo.username = username
            }
            
            if let playlists = userData["favoritedPlaylists"] as? NSMutableArray {
                userInfo.favoritedPlaylists = playlists
            }
            
            if let id = userData["id"] as? String {
                userInfo.id = id
                self.fetchUserLikes(id, completion: { (truthValue) in
                    completion(userInfo)
                })
            } else {
                completion(userInfo)
            }
        })
    }
    
    /* Fetch users likes */
    func fetchUserLikes(_ uid: String, completion: @escaping (Bool) -> ()) {
        api.db.collection("likes").document(uid).getDocument { (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                completion(false)
                return
            }
            
            guard let document = querySnapshot?.data() else { return }
            for ids in document.keys {
                self.likeIds.insert(ids)
            }
            completion(true)
        }
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
    
    /* Like */
    func likePlaylist(_ playlist: Playlist, completion: @escaping () -> ()) {
        api.likePlaylist((user?.id)!, playlist: playlist) { (likeID) in
            self.likeIds.insert(likeID)
            completion()
        }
    }
    
    /* Unlike */
    func unlikePlaylist(_ playlist: Playlist, completion: @escaping () -> ()) {
        api.unlikePlaylist((user?.id)!, playlist: playlist) { (likeID) in
            self.likeIds.remove(likeID)
            completion()
        }
    }
    
    /* Check if like is in set */
    func checkIfLikeExists(_ playlistID: String) -> Bool {
        return likeIds.contains(playlistID)
    }
}
