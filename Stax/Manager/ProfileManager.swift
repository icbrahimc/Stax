//
//  ProfileManager.swift
//  Stax
//
//  Created by icbrahimc on 12/26/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

class ProfileManager: NSObject {
    var user: User?
    
    static let sharedInstance = ProfileManager(api: BaseAPI.sharedInstance)
    
    fileprivate let api: BaseAPI
    
    init(api: BaseAPI) {
        self.api = api
    }
    
    func fetchUserInfo(_ completion: () -> ()) {
        let userCollection = api.db.collection("users")
        
    }
}
