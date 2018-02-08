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
import SwiftyJSON
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
    
    /* Add comment */
    func comment(_ user: User, playlist: Playlist, commentText: String, completion: @escaping (JSON) -> ()) {
        // Time stamps.
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        let commentID = UUID().uuidString
        let commentRef = db.collection("comments").document(playlist.id!)
        
        let commentDataDic = [
            "userID" : user.id ?? "" as Any,
            "username" : user.username ?? "" as Any,
            "text" : commentText,
            "date" : time,
            "id" : commentID
        ] as [String : Any]
        
        commentRef.setData([commentID : commentDataDic], options: SetOptions.merge()) { (err) in
            if let error = err {
                print(error.localizedDescription)
                completion(JSON.null)
                return
            }
            print("Successfully added comment to playlist \(playlist.id!)")
            let commentJSON = JSON(commentDataDic)
            completion(commentJSON)
        }
    }
    
    /* Follow */
    func follow(_ user: User, userToFollow: User, completion: @escaping (String) -> ()) {
        // Time stamps.
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        // This data corresponds to the data of the followed (user who is being followed).
        let followingData = [
            "id" : userToFollow.id ?? "",
            "username" : userToFollow.username ?? "",
            "date" : time
        ] as [String : Any]
        
        // This data corresponds to the data of the follower (user who follows another).
        let followerData = [
            "id" : user.id ?? "",
            "username" : user.username ?? "",
            "date" : time
        ] as [String : Any]
        
        let followingRef = db.collection("users").document(user.id!).collection("following").document(userToFollow.id!)
        let followRef = db.collection("users").document(userToFollow.id!).collection("followers").document(user.id!)
        
        followingRef.setData(followingData) { (err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            print("Successfully followed user")
            followRef.setData(followerData, completion: { (err) in
                if let error = err {
                    print(error.localizedDescription)
                    return
                }
                completion(userToFollow.id!)
            })
        }
    }
    
    /* Unfollow */
    func unfollow(_ user: User, userToUnfollow: User, completion: @escaping (String) -> ()) {
        let followingRef = db.collection("users").document(user.id!).collection("following").document(userToUnfollow.id!)
        let followRef = db.collection("users").document(userToUnfollow.id!).collection("followers").document(user.id!)
        
        followingRef.delete { (err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            print("Successfully removed user from following category")
            followRef.delete { (err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                print("Successfully removed user from followers category")
                completion(userToUnfollow.id!)
            }
        }
    }
    
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
    
    ///////////////* Database Queries *///////////////////////
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
