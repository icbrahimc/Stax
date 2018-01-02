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
    
    /////////////////* Adding to Database */////////////////
    
    /* add a playlist to the database */
    func addPlaylist(playlist: Playlist) {
        let user = getUserGivenUsername(username: playlist.creatorUsername)

        let playlistReference = db.collection("playlists").addDocument(data: [
            "name": playlist.name!,
            "rating": playlist.rating.doubleValue,
            "favorites": playlist.numFavorites.doubleValue,
            "num_ratings": playlist.numRatings.intValue,
            "apple_link": playlist.appleLink!,
            "cloud_link": playlist.cloudLink!,
            "spotify_link": playlist.spotifyLink!,
            "cover_art_link": playlist.coverArtLink!,
            "tags": playlist.tags! as NSArray as! [String],
            "creator": user
        ]) { (error: Error?) in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Playlist, \(playlist.name!), added successfully")
            }
        }
        
       // db.collection("users").document(playlist.creatorUsername!).updateData(
        //TODO: add a reference from the user to this new playlist
        //)
        
    }
    
    /* Add a user to the database */
    func addUser(user: User) {
        db.collection("users").document(user.username!).setData([
            "name": user.name!,
            "id": user.id!.doubleValue
        ])
    }
    
    /////////////////* Updating in Database *///////////////////
    
    //TODO: add in enums so that there is just one update function
    
    /* Update a playlist rating */
    func updatePlaylistRating(playlist: Playlist) {
        db.collection("playlists").document(playlist.id!).updateData(
            [
                "num_ratings": playlist.numRatings.doubleValue,
                "rating": playlist.rating.doubleValue,
            ]
        )
    }
    
    /* Increment number of favorites for a playlist */
    func updatePlaylistFavorites(playlist: Playlist) {
        db.collection("playlists").document(playlist.id!).updateData(
            ["favorites": playlist.numFavorites.doubleValue]
        )
    }
    
    /* Update a user's name */
    func updateName(user: User) {
        db.collection("users").document(user.username!).setData(["name": user.name!], options: SetOptions.merge())
    }
    
    func tester2(username: String, name: String) {
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "name": name,
        ]) { err in
            if let err = err {
                print("error adding document: \(err)")
            } else {
                print("document added with id: \(ref!.documentID)")
            }
        }
    }
    
    func tester (username: String) {
        db.collection("users").document(username).getDocument { (document, error) in
            if let document = document {
                let favoritedPlaylists = document.data()
                print("Document data: \(favoritedPlaylists)")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    /* Favorite a playlist */
    func favoritePlaylist(user: User, playlist: Playlist) {
        let playlistRef = db.collection("playlists").document(playlist.id!);
        //let favoritedPlaylists = db.collection("users").document(user.username!).
        //db.collection("users").document(user.username!).updateData(["favorited_playlists": ])
    }
    
    /* Unfavorite a playlist */
    func unFavoritePlaylist(user: User, playlist: Playlist) {
        let playlistRef = db.collection("playlists").document(playlist.id!);
        db.collection("users").document(user.username!).getDocument { (document, error) in
            if let document = document {
                let favoritedPlaylists = document.data()
                print("Document data: \(favoritedPlaylists)")
            } else {
                print("Document does not exist")
            }
        }
        //db.collection("users").document(user.username!).updateData(["favorited_playlists": ])
    }
    
    /* Rate a playlist */
    func ratePlaylist(user: User, playlist: Playlist) {
        //get all rated playlists as an array
        //add this playlist to the list
        //set data
    }
    
    ///////////////* Database Queries *///////////////////////
    
    /* Get the top rated playlists */
    func getTopRatedPlaylists(numPlaylists: Int) -> Query {
        let playlists = db.collection("playlists");
        return playlists.order(by: "rating", descending: true)
    }
    
    /* Get the top favorited playlists */
    func getTopFavoritedPlaylists(numPlaylists: Int) -> Query {
        let playlists = db.collection("playlists");
        return playlists.order(by: "favorites", descending: true)
    }
    
    /* Get all playlists with a certain tag */
    
    /* Get a playlist given it's id */
    func getPlaylistGivenId(id: String?) -> DocumentReference {
        return db.collection("playlists").document(id!)
    }
    
    /* Get a user given their username */
    func getUserGivenUsername(username: String?) -> DocumentReference {
        return db.collection("users").document(username!)
    }
    
}
