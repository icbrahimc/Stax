//
//  BaseAPI.swift
//  Stax
//
//  Created by icbrahimc on 12/20/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Foundation
import FirebaseFirestore

/* This is the base api class for the application. */
class BaseAPI: NSObject {
    static let sharedInstance = BaseAPI()
    
    override private init() {
    }
    
    let db = Firestore.firestore();
    
    /* Get the top rated playlists with a certain limit */
    func getTopPlaylists(numPlaylists: NSNumber) -> Query {
        let playlists = self.db.collection("playlists");
        return playlists.order(by: "rating", descending: true).limit(to: numPlaylists.intValue);
    }
}
