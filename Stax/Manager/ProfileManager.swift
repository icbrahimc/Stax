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
    
    func fetchUserInfo(_ completion: @escaping () -> ()) {
        api.loadUserInfo({ (userData) in
            if let username = userData["username"] as? String {
                self.user?.username = username
            }
            
            if let id = userData["id"] as? String {
                self.user?.id = id
            }
            
            if let playlist = userData["favoritedPlaylists"] as? NSMutableArray {
                self.user?.favoritedPlaylists = playlist
            }
            print("Profile manager \(self.user?.id)")
            completion()
        })
    }
}
