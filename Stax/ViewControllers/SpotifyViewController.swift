//
//  SpotifyViewController.swift
//  Stax
//
//  Created by icbrahimc on 2/14/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import Alamofire
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
