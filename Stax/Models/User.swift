//
//  User.swift
//  Stax
//
//  Created by icbrahimc on 12/17/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Foundation

class User: NSObject {
    var id: NSNumber?
    var username: String?
    var name: String? = ""
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


