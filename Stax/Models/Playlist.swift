//
//  Playlist.swift
//  Stax
//
//  Created by icbrahimc on 12/14/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Foundation

class Playlist: NSObject {
    var id: String?
    var name: String?
    var creatorUsername: String?
    var spotifyLink: String?
    var appleLink: String?
    var cloudLink: String?
    var rating: NSNumber = 0.0
    var coverArtLink: String?
    var songs: NSMutableArray?
    var numRatings: NSNumber = 0.0
    var numFavorites: NSNumber = 0.0
    var tags: NSMutableArray?
    
    func updateRating(newRating: NSNumber) {
        let totalRating = self.rating.doubleValue * self.numRatings.doubleValue + newRating.doubleValue
        self.numRatings = NSNumber (value: self.numRatings.doubleValue + 1)
        self.rating = NSNumber (value: totalRating/self.numRatings.doubleValue)
        BaseAPI.sharedInstance.updatePlaylistRating(playlist: self)
    }
    
    //pass in 1 or -1, 1 to increment favorites, -1 to decrement favorites
    func updateFavorites(incOrDec: NSNumber) {
        self.numFavorites = NSNumber (value: self.numFavorites.doubleValue + incOrDec.doubleValue)
        BaseAPI.sharedInstance.updatePlaylistFavorites(playlist: self)
    }
}


