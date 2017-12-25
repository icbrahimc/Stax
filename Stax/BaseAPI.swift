//
//  BaseAPI.swift
//  Stax
//
//  Created by icbrahimc on 12/20/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Foundation
import Firebase
import Firestore

/* This is the base api class for the application. */
class BaseAPI: NSObject {
    static let sharedInstance = BaseAPI()
    var db: Firestore!
    
    override private init() {
        let settings = FirestoreSettings();
        Firestore.firestore().settings = settings;
        db = Firestore.firestore();
    }
    
    /* a test function to add a playlist to the database */
    func addHaileyPlaylist() {
        print("in hailey playlist")
        print(db)
        db.collection("playlists").addDocument(data: [
            "name": "Hailey's Bomb",
            "rating": 5.0,
            ]) { (error:Error?) in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully")
            }
        }
    }

    /* Get the top rated playlists with a certain limit */
    func getTopPlaylists(numPlaylists: Int) -> Query {
        let playlists = db.collection("playlists");
        return playlists.order(by: "rating", descending: true).limit(to: numPlaylists);
    }
}
