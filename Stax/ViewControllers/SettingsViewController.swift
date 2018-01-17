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
import UIKit

class SettingsViewController: UITableViewController {
    
    var appleMusicCell: UITableViewCell = UITableViewCell()
    var logoutCell: UITableViewCell = UITableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            case 0: return self.appleMusicCell  // section 0, row 0 is the first name
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
        case 0: return 1    // section 0 has 1 rows
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
        
        // Logout cell
        self.logoutCell.textLabel?.text = "Logout"
    }
}
