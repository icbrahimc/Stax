//
//  Playlist.swift
//  Stax
//
//  Created by icbrahimc on 12/14/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Foundation

class Playlist: NSObject {
    var id: NSNumber?
    var name: String?
    var author: String?
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
        let totalRating = self.rating.doubleValue * self.numRatings.doubleValue + newRating.doubleValue;
        self.numRatings = NSNumber (value: self.numRatings.doubleValue + 1);
        self.rating = NSNumber (value: totalRating/self.numRatings.doubleValue);
    }
    
    func incrementFavorites() {
        self.numFavorites = NSNumber (value: self.numFavorites.doubleValue + 1);
    }
}


