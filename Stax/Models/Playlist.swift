//
//  Playlist.swift
//  Stax
//
//  Created by icbrahimc on 12/14/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Foundation

struct Playlist {
    var id: String?
    var title: String?
    var description: String?
    var creatorUsername: String?
    var spotifyLink: String?
    var appleLink: String?
    var cloudLink: String?
    var youtubeLink: String?
//    var rating: NSNumber = 0.0
    var coverArtLink: String?
    var likes: NSMutableArray?
//    var songs: NSMutableArray?
//    var numRatings: NSNumber = 0.0
//    var numFavorites: NSNumber = 0.0
//    var tags: NSMutableArray?
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
    }
    
//    func updateRating(newRating: NSNumber) {
//        let totalRating = self.rating.doubleValue * self.numRatings.doubleValue + newRating.doubleValue
//        self.numRatings = NSNumber (value: self.numRatings.doubleValue + 1)
//        self.rating = NSNumber (value: totalRating/self.numRatings.doubleValue)
//        BaseAPI.sharedInstance.updatePlaylistRating(playlist: self)
//    }
//    
//    //pass in 1 or -1, 1 to increment favorites, -1 to decrement favorites
//    func updateFavorites(incOrDec: NSNumber) {
//        self.numFavorites = NSNumber (value: self.numFavorites.doubleValue + incOrDec.doubleValue)
//        BaseAPI.sharedInstance.updatePlaylistFavorites(playlist: self)
//    }
}


