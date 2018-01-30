//
//  SettingsViewController.swift
//  Stax
//
//  Created by icbrahimc on 1/17/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
import GoogleSignIn
import MediaPlayer
import StoreKit
import SpotifyLogin
import UIKit

class SettingsViewController: UITableViewController {
    
    var appleMusicCell: UITableViewCell = UITableViewCell()
    var spotifyCell: UITableViewCell = UITableViewCell()
    var logoutCell: UITableViewCell = UITableViewCell()
    
    // Spotify
    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession!
    var player: SPTAudioStreamingController?
    var loginUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.appleMusicCell
            case 1: return self.spotifyCell
            default: fatalError("Unknown row in section 0")
            }
        case 1:
            switch(indexPath.row) {
            case 0: return self.logoutCell      // section 1, row 0 is the share option
            default: fatalError("Unknown row in section 1")
            }
        default: fatalError("Unknown section")
        }
    }

    // Return the number of rows for each section in your static table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 2    // section 0 has 2 rows
        case 1: return 1    // section 1 has 1 row
        default: fatalError("Unknown number of sections")
        }
    }
    
    // Customize the section headings for each section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0: return "Music Services"
        case 1: return "Logout"
        default: fatalError("Unknown section")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section) {
        case 0:
            switch(indexPath.row) {
                
            case 0:
                tableView.deselectRow(at: indexPath, animated: false)
                AppleMusicManager.sharedInstance.appleMusicRequestPermission(self, completion: { (authorized) in
                    print("Ibrahim good")
                })
                break
                
            case 1:
                tableView.deselectRow(at: indexPath, animated: false)
                SpotifyLogin.shared.getAccessToken(completion: { (token, err) in
                    if let err = err {
                        print(err.localizedDescription)
                        SpotifyLoginPresenter.login(from: self, scopes: [.playlistReadPrivate, .playlistReadCollaborative])
                    }
                    
                    print("Client token \(token)")
                })
                break
                
            default:
                break
            }
        case 1:
            switch(indexPath.row) {
                
            case 0:
                tableView.deselectRow(at: indexPath, animated: false)
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    GIDSignIn.sharedInstance().signOut()
                    let loginManager = FBSDKLoginManager()
                    loginManager.logOut() // this is an instance function
                    ProfileManager.sharedInstance.clearUserInfo {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "SignoutNotification"), object: nil)
                    }
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
                break
                
            default:
                break
            }
        default:
            break
        }
    }
}

extension SettingsViewController {
    func layout() {
        // Apple music cell
        self.appleMusicCell.textLabel?.text = "Apple Music"
        
        // Spotify music cell
        self.spotifyCell.textLabel?.text = "Spotify"
        
        // Logout cell
        self.logoutCell.textLabel?.text = "Logout"
    }
}
