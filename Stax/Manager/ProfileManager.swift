//
//  ProfileManager.swift
//  Stax
//
//  Created by icbrahimc on 12/26/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

let UserInfoUpdated = "UserInfoUpdated"

class ProfileManager: NSObject {
    var user: User? {
        didSet {
            NotificationCenter.default.post(name: Notification.Name(rawValue: UserInfoUpdated), object: nil)
        }
    }
    
    static let sharedInstance = ProfileManager(api: BaseAPI.sharedInstance)
    
    fileprivate let api: BaseAPI
    
    init(api: BaseAPI) {
        self.api = api
    }
    
    func fetchUserInfo(_ completion: () -> ()) {
        api.loadUserInfo({ (userData) in
            self.user?.username = userData["username"] as! String
            self.user?.id = userData["id"] as! String
            self.user?.favoritedPlaylists = userData["favoritedPlaylists"] as! NSMutableArray
        })
    }
}
