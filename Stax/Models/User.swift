//
//  User.swift
//  Stax
//
//  Created by icbrahimc on 12/17/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: String?
    var id: String?
    var favoritedPlaylists: NSMutableArray?
    
    func getNameFromID(id: NSNumber?) -> String? {
        //dummy function for database
        return self.getName();
    }
    
    func getName() -> String? {
        return self.name;
    }
    
    func favoritePlaylist(Playlist: NSObject) {
        self.favoritedPlaylists?.add(Playlist);
    }
    
    func unfavoritePlaylist(Playlist: NSObject) {
        self.favoritedPlaylists?.remove(Playlist);
    }
}



