//
//  Playlist.swift
//  Stax
//
//  Created by icbrahimc on 12/14/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Foundation

struct Playlist {
    /* Playlist id */
    var id: String?
    
    /* Playlist title */
    var title: String?
    
    /* Playlist description */
    var description: String?
    
    /* The username associated with the playlist/post */
    var creatorUsername: String?
    
    /* Music links */
    var spotifyLink: String?
    var appleLink: String?
    var cloudLink: String?
    var youtubeLink: String?

    /* Cover art link. This links to the db. */
    var coverArtLink: String?
    
    /* The users who liked the playlist */
    var likes: NSMutableArray?
    
    /* Date */
    let date: Date?

    init() {
        self.id = ""
        self.title = ""
        self.description = ""
        self.creatorUsername = ""
        self.spotifyLink = ""
        self.appleLink = ""
        self.cloudLink = ""
        self.youtubeLink = ""
        self.coverArtLink = ""
        self.likes = []
        self.date = Date()
    }
    
    init(id: String, title: String, description: String, creatorUsername: String, spotifyLink: String, appleLink: String, cloudLink: String, youtubeLink: String, coverArtLink: String, likes: NSMutableArray) {
        self.id = id
        self.title = title
        self.description = description
        self.creatorUsername = creatorUsername
        self.spotifyLink = spotifyLink
        self.appleLink = appleLink
        self.cloudLink = cloudLink
        self.youtubeLink = youtubeLink
        self.coverArtLink = coverArtLink
        self.likes = likes
        self.date = Date()
    }
}


