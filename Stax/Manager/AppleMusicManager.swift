//
//  AppleMusicManager.swift
//  Stax
//
//  Created by icbrahimc on 1/17/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import Alamofire
import MediaPlayer
import StoreKit
import SwiftyJSON
import UIKit

class AppleMusicManager: NSObject {
    static let sharedInstance = AppleMusicManager()
    
    // Request permission from the user to access the Apple Music library
    func appleMusicRequestPermission(_ viewController: UIViewController, completion: @escaping (Bool) -> ()) {
        
        switch SKCloudServiceController.authorizationStatus() {
            
        case .authorized:
            print("The user's already authorized - we don't need to do anything more here, so we'll exit early.")
            let alert = UIAlertController(title: "Apple Music Already Authorized", message: "Enjoy posting playlists!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            viewController.present(alert, animated: true, completion: nil)
            self.appleMusicFetchUserToken({ (userID) in
                print(userID)
                
            })
            completion(true)
            return
            
        case .denied:
            print("The user has selected 'Don't Allow' in the past - so we're going to show them a different dialog to push them through to their Settings page and change their mind, and exit the function early.")
            let alert = UIAlertController(title: "Give Apple Music Permission", message: "In order to pull your Apple Music Playlists, please go into your settings and authorize Apple Music", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { (action) in
                guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(settingsAction)
            alert.addAction(cancelAction)
            viewController.present(alert, animated: true, completion: nil)
            return
            
        case .notDetermined:
            
            print("The user hasn't decided yet - so we'll break out of the switch and ask them.")
            break
            
        case .restricted:
            
            print("User may be restricted; for example, if the device is in Education mode, it limits external Apple Music usage. This is similar behaviour to Denied.")
            return
        }
        
        SKCloudServiceController.requestAuthorization { (status:SKCloudServiceAuthorizationStatus) in
            
            switch status {
                
            case .authorized:
                print("All good - the user tapped 'OK', so you're clear to move forward and start playing.")
                completion(true)
                
            case .denied:
                
                print("The user tapped 'Don't allow'. Read on about that below...")
                
            case .notDetermined:
                
                print("The user hasn't decided or it's not clear whether they've confirmed or denied.")
                
            default: break
                
            }
        }
    }
    
    // Fetch the user's storefront ID
    func appleMusicFetchUserToken(_ completion: @escaping (String) -> ()) {
        let serviceController = SKCloudServiceController()
        if #available(iOS 11.0, *) {
            serviceController.requestUserToken(forDeveloperToken: Constants.APPLE) { (userToken, err) in
                guard err == nil else {
                    print("An error occured. Handle it here.")
                    completion("")
                    return
                }
                
                guard let userID = userToken else {
                    print("Handle the error - the callback didn't contain a valid user id.")
                    completion("")
                    return
                }
                
                completion(userID)
            }
        } else {
            // Fallback on earlier versions
            if #available(iOS 10.3, *) {
                serviceController.requestPersonalizationToken(forClientToken: Constants.APPLE, withCompletionHandler: { (userToken, err) in
                    guard err == nil else {
                        print("An error occured. Handle it here.")
                        print(err?.localizedDescription)
                        completion("")
                        return
                    }
                    
                    guard let userID = userToken else {
                        print("Handle the error - the callback didn't contain a valid user id.")
                        completion("")
                        return
                    }
                    
                    completion(userID)
                })
            } else {
                // Fallback on earlier versions
                print("cannot fetch user tokens")
            }
        }
    }
    
    func appleMusicFetchStorefrontRegion(_ completion: @escaping (String) -> ()) {
        let serviceController = SKCloudServiceController()
        serviceController.requestStorefrontIdentifier { (storefrontId:String?, err: Error?) in
            guard err == nil else {
                print("An error occured. Handle it here.")
                return
            }
            
            guard let storefrontID = storefrontId, storefrontID.count >= 6 else {
                print("Handle the error - the callback didn't contain a valid storefrontID.")
                return
            }
            
            let index = storefrontID.index(storefrontID.startIndex, offsetBy: 6)
            let trimmedId = storefrontID[..<index]
            
            print("Success! The user's storefront ID is: \(trimmedId)")
            completion(String(trimmedId))
        }
    }
    
    func getAppleMusicTracks(link: String, completion: @escaping ([Song], Playlist?) -> ()) {
        // Instantiate a new playlist to pass on to the next vc.
        var appleMusicPlaylist: Playlist = Playlist()
        
        // Parse the linkText for the URLS.
        let linkParams = parseAppleLink(link)
        
        let storeFront = linkParams[0]
        let id = linkParams[1]
        
        let apiCall = "https://api.music.apple.com/v1/catalog/\(storeFront)/playlists/\(id)"
        
        let url = URL(string: apiCall)
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Constants.APPLE)"
        ]
        
        appleMusicPlaylist.appleLink = link
        
        // Make the request.
        Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).validate().responseJSON { (data) in
            
            guard let response = data.data else {
                print("Error no data present")
                return
            }
            
            if let err = data.error {
                print(err.localizedDescription)
                completion([], nil)
                return
            }
            
            // Parse JSON data.
            let appleJSON = JSON(response)
            
            let data = appleJSON["data"][0]
            let attributes = data["attributes"]
            
            // Add data to the playlist object.
            if let imageURL = attributes["artwork"]["url"].string {
                let height = attributes["artwork"]["height"].stringValue
                let width = attributes["artwork"]["width"].stringValue
                
                var finalImageURL = imageURL.replacingOccurrences(of: "{w}", with: width)
                finalImageURL = finalImageURL.replacingOccurrences(of: "{h}", with: height)
                
                appleMusicPlaylist.coverArtLink = finalImageURL
            }
            
            if let name = attributes["name"].string {
                appleMusicPlaylist.title = name
            }
            
            appleMusicPlaylist.creatorUsername = ProfileManager.sharedInstance.user?.username
            
            var songs: [Song] = []
            let tracks = data["relationships"]["tracks"]["data"]
            for track in tracks.arrayValue {
                var song = Song()
                let trackAttr = track["attributes"]
                
                song.artistName = trackAttr["artistName"].stringValue
                song.albumName = trackAttr["albumName"].stringValue
                song.sharingURL = trackAttr["url"].stringValue
                songs.append(song)
            }
            completion(songs, appleMusicPlaylist)
        }
    }
    
    /* Spotfiy functions */
    
    /* Get all spotify tracks for a particular playlist */
    func getSpotifyTracks(_ spotUID: String, completion: @escaping ([Song]) -> ()) {
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(ProfileManager.sharedInstance.spotifyMusicID)"
        ]
        
        let username = ProfileManager.sharedInstance.spotifyUsername
        
        let spotURL = "https://api.spotify.com/v1/users/\(username)/playlists/\(spotUID)/tracks"
        
        let url = URL(string: spotURL)
        
        // Include completion handler for when you retrieve all the tracks.
        // Leave blank for now.
        Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).validate().responseJSON { (response) in
            
            guard let data = response.result.value else {
                return
            }
            
            var songs: [Song] = []
            let spotJSON = JSON(data)
            let tracks = spotJSON["items"]
            
            for track in tracks {
                var newTrack = Song()
                let trackJSON = track.1["track"]
                let trackTitle = trackJSON["name"].stringValue
                let trackURL = trackJSON["uri"].stringValue
                
                var artistName = ""
                for artist in trackJSON["artists"] {
                    if artistName == "" {
                        artistName += artist.1["name"].stringValue
                    } else {
                        artistName += ", \(artist.1["name"].stringValue)"
                    }
                }
                
                newTrack.albumName = trackTitle
                newTrack.artistName = artistName
                newTrack.sharingURL = trackURL
                
                songs.append(newTrack)
            }
            
            completion(songs)
        }
    }
}
