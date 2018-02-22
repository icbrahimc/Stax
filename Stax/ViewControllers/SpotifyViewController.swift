//
//  SpotifyViewController.swift
//  Stax
//
//  Created by icbrahimc on 2/14/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

private let spotifyIdentifier = "spotify"

class SpotifyViewController: UITableViewController {
    /* Playlist array */
    var playlists = [Playlist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        title = "Spotify"

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        tableView.register(SpotifyTableViewCell.self, forCellReuseIdentifier: spotifyIdentifier)
        getPlaylists()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Playlist mutators */
    func getPlaylists() {
        SPTPlaylistList.playlists(forUser: ProfileManager.sharedInstance.spotifyUsername, withAccessToken: ProfileManager.sharedInstance.spotifyMusicID) { (err, response) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            if let listPage = response as? SPTPlaylistList, let spotPlaylists = listPage.items as? [SPTPartialPlaylist] {
                self.parseSpotifyPlaylists(spotPlaylists)
                self.tableView.reloadData()
                if listPage.hasNextPage {
                    self.getNextPlaylistPage(listPage)
                }
            }
        }
    }
    
    func getNextPlaylistPage(_ currentPage: SPTListPage) {
        currentPage.requestNextPage(withAccessToken: ProfileManager.sharedInstance.spotifyMusicID, callback: { (error, response) in
            if let page = response as? SPTListPage, let spotPlaylists = page.items as? [SPTPartialPlaylist] {
                self.parseSpotifyPlaylists(spotPlaylists)
                self.tableView.reloadData()
                if page.hasNextPage {
                    self.getNextPlaylistPage(page)
                }
            }
        })
    }
    
    func parseSpotifyPlaylists(_ spotifyData: [SPTPartialPlaylist]) {
        for playlist in spotifyData {
            var spotPlaylist = Playlist()
            spotPlaylist.title = playlist.name
            spotPlaylist.spotifyLink = playlist.uri.absoluteString
            spotPlaylist.coverArtLink = playlist.largestImage.imageURL.absoluteString
            self.playlists.append(spotPlaylist)
        }
    }
    
    func getSpotifyTracks(_ spotUID: String) {
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
            
            let JSON = data as! NSDictionary
            print(JSON)
        }
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playlists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: spotifyIdentifier, for: indexPath) as! SpotifyTableViewCell

        cell.playlist = playlists[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectPlaylist = playlists[indexPath.row]
        let spotUID = parseSpotifyLink(selectPlaylist.spotifyLink!)
//        getSpotifyTracks(spotUID)
        tableView.deselectRow(at: indexPath, animated: true)
        BaseAPI.sharedInstance.addPlaylist(selectPlaylist) { (id) in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "NewPlaylist"), object: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
}