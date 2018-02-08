//
//  Song.swift
//  Stax
//
//  Created by icbrahimc on 2/8/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import Foundation

struct Song {
    var albumName: String?
    var artistName: String?
    var sharingURL: String?
    var title: String?
    var trackNumber: Int?
    
    // Add inits to parse JSON and maps.
    
    init() {
        self.albumName = ""
        self.artistName = ""
        self.sharingURL = ""
        self.title = ""
        self.trackNumber = 0
    }
    
    init(album: String, artist: String, sharingURL: String, title: String, track: Int) {
        self.albumName = album
        self.artistName = artist
        self.sharingURL = sharingURL
        self.title = title
        self.trackNumber = track
    }
}
