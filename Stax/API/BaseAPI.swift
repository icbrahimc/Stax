//
//  BaseAPI.swift
//  Stax
//
//  Created by icbrahimc on 12/25/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import FirebaseCore
import FirebaseFirestore
import UIKit

class BaseAPI: NSObject {
    static let sharedInstance = BaseAPI()
    var db: Firestore!
    
    override private init() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    /* Get the top rated playlists with a certain limit */
    func getTopPlaylists(numPlaylists: Int) -> Query {
        let playlists = db.collection("playlists");
        return playlists.order(by: "rating", descending: true)
    }
    
    /* Check the database for a particular username */
    func findUsername(username: String, completion: @escaping (Bool) -> ()) {
        let documentQuery = db.collection("usernames").document(username)
        documentQuery.getDocument(completion: { (document, err) in
            if let document = document {
                print("Username exists")
                completion(true)
            } else {
                print("Username does not exist")
                completion(false)
            }
        })
    }
}
