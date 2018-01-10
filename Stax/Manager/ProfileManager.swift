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
}
