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
    var rating: Decimal = 0.0
    var coverArtLink: String?
    var songs: NSMutableArray?
    var numRatings: Decimal = 0.0
    var numFavorites: Decimal = 0.0
    var tags: NSMutableArray?
    
    func updateRating(newRating: Decimal) {
        let totalRating = self.rating * self.numRatings + newRating;
        self.numRatings = self.numRatings + 1;
        self.rating = totalRating/self.numRatings;
    }
    
    func incrementFavorites() {
        self.numFavorites = self.numFavorites + 1;
    }
}


