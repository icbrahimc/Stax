//
//  User.swift
//  Stax
//
//  Created by icbrahimc on 12/17/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Foundation

struct User {
    var username: String?
    var id: String?
    var favoritedPlaylists: NSMutableArray?
    var createdPlaylists: NSMutableArray?
    var ratedPlaylists: NSMutableArray?
    
    /* Update or set a user's name */
    func updateName(name: String) {
        self.name = name
        BaseAPI.sharedInstance.updateName(user: self)
    }
    
    func ratePlaylist(playlist: Playlist, rating: NSNumber) {
        playlist.updateRating(newRating: rating)
        BaseAPI.sharedInstance.ratePlaylist(user: self, playlist: playlist)
      
    init(username: String, id: String, favoritedPlaylists: NSMutableArray) {
        self.username = username
        self.id = id
        self.favoritedPlaylists = favoritedPlaylists
    }
    
    func getNameFromID(id: NSNumber?) -> String? {
        //dummy function for database
        return self.getName();
    }
    
    func getName() -> String? {
        return self.username;
    }
    
    func favoritePlaylist(playlist: Playlist) {
        self.favoritedPlaylists?.add(playlist)
        playlist.updateFavorites(incOrDec: 1)
        BaseAPI.sharedInstance.favoritePlaylist(user: self, playlist: playlist)
    }
    
    func unfavoritePlaylist(playlist: Playlist) {
        self.favoritedPlaylists?.remove(playlist)
        playlist.updateFavorites(incOrDec: -1)
        BaseAPI.sharedInstance.unFavoritePlaylist(user: self, playlist: playlist)
    }
}


