//
//  BaseAPI.swift
//  Stax
//
//  Created by icbrahimc on 12/25/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
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
    func addPlaylist(_ playlist: Playlist, completionBlock: @escaping (String) -> ()) {
        let user = "icbrahimc"
        var playlistRef: DocumentReference? = nil
        playlistRef = db.collection("playlists").addDocument(data: [
            "id": playlistRef?.documentID,
            "title" : playlist.title,
            "description": playlist.description,
            "creatorUsername": user,
            "appleMusicLink": playlist.appleLink,
            "spotifyMusicLink": playlist.spotifyLink,
            "soundcloudLink": playlist.cloudLink,
            "youtubeLink": playlist.youtubeLink,
            "coverartLink": playlist.coverArtLink,
            "likes": playlist.likes,
        ]) { (error: Error?) in
            if let error = error {
                print("Error adding playlist: \(error)")
                return
            } else {
                print("Playlist, \(playlistRef?.documentID), added successfully")
                completionBlock((playlistRef?.documentID)!)
            }
        }
        //TODO: add a reference from this playlist to the playlist creator's created playlists list
    }
    
    /* save a photo in the db */
    func savePhotoIntoDB(_ playlistId: String, image: UIImage, completionBlock: @escaping () -> ()) {
        let storageRef = Storage.storage().reference().child("playlists").child("\(playlistId).png")
        
        if let uploadData = UIImagePNGRepresentation(image) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                if let playlistImageURL = metadata?.downloadURL()?.absoluteString {
                    self.db.collection("playlists").document(playlistId).updateData([
                        "id": playlistId,
                        "coverartLink": playlistImageURL
                    ], completion: { (error) in
                        if let error = error {
                            print("Could not save photo in the repository")
                            return
                        } else {
                            print("Playlist photo saved!")
                            completionBlock()
                        }
                    })
                }
            })
        }
    }
    
    /////////////////* User functions */////////////////
    
    /* Favorite a playlist */
    func likePlaylist(_ uid: String, playlist: Playlist, completion: @escaping (String) -> ()) {
        // Time stamps.
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        let likeRef = db.collection("likes").document(uid)
        let playlistRef = db.collection("playlists").document(playlist.id!)
        playlistRef.setData(["likes" : [uid : true]], options: SetOptions.merge()) { (err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            print("Successfully liked playlist")
            likeRef.setData([playlist.id! : ["id" : uid, "date" : time]], options: SetOptions.merge(), completion: { (err) in
                if let error = err {
                    print(error.localizedDescription)
                    return
                }
                print("User like recorded")
                completion(playlist.id!)
            })
        }
    }
    
    /* Unfavorite a playlist */
    func unlikePlaylist(_ uid: String, playlist: Playlist, completion: @escaping (String) -> ()) {
        // Time stamps.
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        let likeRef = db.collection("likes").document(uid)
        let playlistRef = db.collection("playlists").document(playlist.id!)
        playlistRef.updateData(["likes.\(uid)" : FieldValue.delete()], completion: { (err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            print("Successfully unliked playlist")
            likeRef.updateData([playlist.id! : FieldValue.delete()], completion: { (err) in
                if let error = err {
                    print(error.localizedDescription)
                    return
                }
                print("User dislike recorded")
                completion(playlist.id!)
            })
        })
        //TODO: get current favorited playlists, remove the playlistRef from that list, then set the favorited playlists to the list with the one removed
    }
    
    
    /* Add a user to the database */
    func addUser(user: User) {
//        db.collection("users").document(user.username!).setData([
////            "name": user.name!,
////            "id": user.id!.doubleValue
//        ]) { (error: Error?) in
//            if let error = error {
//                print("Error adding user: \(error)")
//            } else {
//                print("User, \(user.username!), added successfully")
//            }
//        }
    }
    
    /////////////////* Updating in Database *///////////////////
    
    //TODO: add in enums so that there is just one update function that takes in as a paramater the playlist, what to update (ex. rating, favorites, name, links), and what to update to and have switch cases for each of those options
    
    /* Update a playlist rating */
    func updatePlaylistRating(playlist: Playlist) {
//        db.collection("playlists").document(playlist.id!).updateData(
//            [
//                "num_ratings": playlist.numRatings.doubleValue,
//                "rating": playlist.rating.doubleValue,
//            ]
//        ) { (error: Error?) in
//            if let error = error {
//                print("Error updating playlist rating: \(error)")
//            } else {
//                print("Playlist, \(playlist.name!) rating successfully updated to \(playlist.rating.doubleValue)")
//            }
//        }
    }
    
    /* Increment number of favorites for a playlist */
    func updatePlaylistFavorites(playlist: Playlist) {
//        db.collection("playlists").document(playlist.id!).updateData(
//            ["favorites": playlist.numFavorites.doubleValue]
//        ) { (error: Error?) in
//            if let error = error {
//                print("Error updating playlist favorites: \(error)")
//            } else {
//                print("Playlist, \(playlist.name!) num favorites successfully updated to \(playlist.numFavorites.doubleValue)")
//            }
//        }
    }
    
    /* Update a user's name */
    func updateName(user: User) {
//        db.collection("users").document(user.username!).setData(["name": user.name!], options: SetOptions.merge()) { (error: Error?) in
//            if let error = error {
//                print("Error updating user's name: \(error)")
//            } else {
//                print("User, \(user.username!), name successfully updated to \(user.name!)")
//            }
//        }
    }
    
    /* Rate a playlist */
    func ratePlaylist(user: User, playlist: Playlist) {
        //TODO: get all rated playlists, add this playlist to the list, set rated playlists to this list with the new one added
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
    
    /* Create a new user */
    func createNewUser(_ id: String) {
        let data = [
            "id": id,
            "username": "",
            "favoritedPlaylists": [],
        ] as [String : Any]
        db.collection("users").document(id).setData(data)
    }
    
    /* Create username */
    func createNewUsername(_ id: String, username: String) {
        db.collection("users").document(id).updateData(["username": username])
        db.collection("usernames").document(username).setData(["id": id])
    }
    
    /* Load the user info */
    func loadUserInfo(_ completion: @escaping ([String:Any]) -> ()) {
        Auth.auth().addStateDidChangeListener({ (auth, user) in
            guard let userID = user?.uid else {
                completion([:])
                return
            }

            let collection = self.db.collection("users").document(userID)
            collection.getDocument(completion: { (document, err) in
                if let error = err {
                    print("loadUserInfo error: \(error.localizedDescription)")
                    completion([:])
                    return
                }
                
                if let document = document {
                    if document.exists {
                        completion(document.data())
                        return
                    }
                    completion([:])
                }
            })
        })
    }
}
