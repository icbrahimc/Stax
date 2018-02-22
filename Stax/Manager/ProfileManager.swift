//
//  ProfileManager.swift
//  Stax
//
//  Created by icbrahimc on 12/26/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import PromiseKit
import SpotifyLogin
import UIKit

let UserInfoUpdated = "UserInfoUpdated"

class ProfileManager: NSObject {
    /* The overarching user model */
    var user: User?
    
    static let sharedInstance = ProfileManager(api: BaseAPI.sharedInstance)
    
    fileprivate let api: BaseAPI
    
    /* Default init */
    init(api: BaseAPI) {
        self.api = api
        self.user = User(username: "", id: "", favoritedPlaylists: NSMutableArray())
        
        /* test code for saving and unsaving playlists */
        
//        let fakePlaylist1: Playlist = Playlist(id: "777", title: "Fake Playlist Title", description: "The worst playlist", creatorUsername: "icbrahimc", spotifyLink: "", appleLink: "", cloudLink: "", youtubeLink: "", coverArtLink: "", likes: NSMutableArray())
//
//        let fakePlaylist2: Playlist = Playlist(id: "123", title: "Some playlist title", description: "The best playlist", creatorUsername: "omarb97", spotifyLink: "", appleLink: "", cloudLink: "", youtubeLink: "", coverArtLink: "", likes: NSMutableArray())
//        let fakeUser: User = User(username: "Dev", id: "HZyauwX54NhRP1All1PGKaYVXJy1", favoritedPlaylists: NSMutableArray())
//        api.savePlaylist(user: fakeUser, playlist: fakePlaylist1, completion: { (playlistID) in
//            print(playlistID)
//        })
//        api.savePlaylist(user: fakeUser, playlist: fakePlaylist2, completion: { (playlistID) in
//            print(playlistID)
//        })
//        api.unsavePlaylist(user: fakeUser, playlist: fakePlaylist, completion: { (playlistId) in
//            print(playlistId)
//        })
        
    }
    
    /* Like ids associated with this particular user */
    var likeIds: Set<String> = Set()
    
    /* Save ids associated with this particular user */
    var savedPlaylistIds: NSMutableArray = NSMutableArray()
    
    /* Apple music id associated with the user */
    var appleMusicID: String = ""
    
    /* Spotify username associated with the user */
    var spotifyUsername: String = ""
    
    /* Spotify id asscoiated with the user */
    var spotifyMusicID: String = ""
    
    /* Clear user info */
    func clearUserInfo(_ completion: @escaping () -> ()) {
        user?.id = ""
        user?.username = ""
        user?.favoritedPlaylists = NSMutableArray()
        likeIds = Set()
        completion()
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
                self.fetchUserLikes(id, completion: { (truthValue) in
                    self.fetchUserSavedPlaylists(id, completion: { (truthValue) in
                        completion(userInfo)
                    })
                })
            } else {
                completion(userInfo)
            }
        })
    }
    
    /* Fetch users likes */
    func fetchUserLikes(_ uid: String, completion: @escaping (Bool) -> ()) {
        api.db.collection("likes").document(uid).getDocument { (querySnapshot, err) in
            if let error = err {
                print(error.localizedDescription)
                completion(false)
                return
            }
            
            guard let document = querySnapshot else { return }
            if document.exists {
                for ids in document.data().keys {
                    self.likeIds.insert(ids)
                }
            }
            completion(true)
        }
    }
    
    /* Fetch user saved playlists */
    func fetchUserSavedPlaylists(_ uid: String, completion: @escaping (Bool) -> ()) {
        api.db.collection("users").document(uid).collection("savedPlaylists").order(by: "date", descending: true).getDocuments { (querySnapshot, err) in
            if let error = err {
                print(error.localizedDescription)
                completion(false)
                return
            }
            
            for document in (querySnapshot?.documents)! {
                print(document.documentID)
                // get playlist ids and put in arraylist in order of timestamp
                self.savedPlaylistIds.add(document.documentID)
            }
            completion(true)
        }
    }
    
    /* Return if the user has a username */
    func userHasUsername() -> Bool {
        if user?.username != nil && user?.username != "" {
            return true
        }
        return false
    }
    
    /* Check if the username exists in the database */
    func usernameExistsInDB(_ username: String, completion: @escaping (Bool) -> ()) {
        api.db.collection("usernames").document(username).getDocument { (document, error) in
            if let err = error {
                print("usernameExistInDb error: \(err.localizedDescription)")
                completion(false)
                return
            } else {
                if (document?.exists)! {
                    completion(true)
                    return
                }
                completion(false)
            }
        }
    }
    
    /* Create new user flag */
    func userExistsInDB(_ uid: String, completion: @escaping (Bool, Bool) -> ()) {
        var userBool: Bool = false
        var usernameBool: Bool = false
        api.db.collection("users").document(uid).getDocument(completion: { (document, error) in
            if let err = error {
                print("userExistInDb error: \(err.localizedDescription)")
                completion(userBool, usernameBool)
            } else {
                userBool = true
                guard let _ = document!["username"] else {
                    usernameBool = false
                    print("Username does not exist")
                    completion(userBool, usernameBool)
                    return
                }
                usernameBool = true
                completion(userBool, usernameBool)
            }
        })
    }
    
    /* Like */
    func likePlaylist(_ playlist: Playlist, completion: @escaping () -> ()) {
        api.likePlaylist((user?.id)!, playlist: playlist) { (likeID) in
            self.likeIds.insert(likeID)
            completion()
        }
    }
    
    /* Unlike */
    func unlikePlaylist(_ playlist: Playlist, completion: @escaping () -> ()) {
        api.unlikePlaylist((user?.id)!, playlist: playlist) { (likeID) in
            self.likeIds.remove(likeID)
            completion()
        }
    }
    
    /* Check if like is in set */
    func checkIfLikeExists(_ playlistID: String) -> Bool {
        return likeIds.contains(playlistID)
    }
}
