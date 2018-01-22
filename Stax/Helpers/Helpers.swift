//
//  Helpers.swift
//  Stax
//
//  Created by icbrahimc on 1/21/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import Foundation

func parseAppleLink(_ url: String) -> [String] {
    var stringList: [String] = []
    let parsedString = url.suffix(url.count - 25)
    
    var storefront: String = String()
    var idx: Int = 0
    var count: Int = 0
    var foundFirst: Bool = false
    
    for char in parsedString {
        if char == "/" {
            foundFirst = true
            idx = count
        }
        
        if !foundFirst {
            storefront.append(char)
        }
        count += 1
    }
    
    let playlist: String = String(parsedString)
    let playlistID = playlist.suffix(playlist.count - idx - 1)
    
    stringList.append(storefront)
    stringList.append(String(playlistID))
    
    return stringList
}
