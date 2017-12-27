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
    
    func favoritePlaylist(Playlist: NSObject) {
        self.favoritedPlaylists?.add(Playlist);
    }
    
    func unfavoritePlaylist(Playlist: NSObject) {
        self.favoritedPlaylists?.remove(Playlist);
    }
}



