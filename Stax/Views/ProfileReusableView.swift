//
//  ProfileReusableView.swift
//  Stax
//
//  Created by icbrahimc on 12/24/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

class ProfileReusableView: UICollectionReusableView {
    let nameLabelSize: CGFloat = {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return 22
        case 1334:
            // iPhones 6, 7, 8
            return 24
        case 2208:
            // iPhones plus
            return 28
        case 2436:
            // X
            return 36
        default:
            return 32
        }
    }()
    
    let numberSize: CGFloat = {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return 12
        case 1334:
            // iPhones 6, 7, 8
            return 12
        case 2208:
            // iPhones plus
            return 14
        case 2436:
            // X
            return 16
        default:
            return 20
        }
    }()
    
    let playlistNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "15"
        return label
    }()
    
    let playlistLabel: UILabel = {
        let label = UILabel()
        label.text = "playlists"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.init(white: 0.4, alpha: 0.6)
        return label
    }()
    
    let followersNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "640"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.text = "followers"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.init(white: 0.4, alpha: 0.6)
        return label
    }()
    
    let followingNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "780"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.text = "following"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.init(white: 0.4, alpha: 0.6)
        return label
    }()
    
    let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ibrahim"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Conteh"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@icbrahimc"
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.textColor = UIColor.init(white: 0.4, alpha: 0.6)
        return label
    }()
    
    let dividerLineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let editProfileButtton: UIButton = {
        let button = UIButton(type: UIButtonType.roundedRect)
        button.setTitle("Edit Profile", for: .normal)
        button.backgroundColor = UIColor(red:211.0/255.0, green:72.0/255.0, blue:54.0/255.0, alpha:1.0)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        return button
    }()
    
    let profilePic: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "moon")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 37.5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        addSubview(profilePic)
        addSubview(firstNameLabel)
        addSubview(lastNameLabel)
        addSubview(playlistNumberLabel)
        addSubview(playlistLabel)
        addSubview(usernameLabel)
        addSubview(dividerLineView)
        addSubview(followersLabel)
        addSubview(followingLabel)
        addSubview(followersNumberLabel)
        addSubview(followingNumberLabel)
        addSubview(editProfileButtton)
        
        backgroundColor = .white
        profilePic.autoSetDimension(.height, toSize: frame.height * 0.40)
        profilePic.autoSetDimension(.width, toSize: frame.height * 0.40)
        profilePic.autoPinEdge(toSuperviewEdge: .top, withInset: 30)
        profilePic.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        profilePic.layer.cornerRadius = frame.height * 0.20
        
        firstNameLabel.autoSetDimension(.width, toSize: 100)
        firstNameLabel.autoPinEdge(.left, to: .left, of: profilePic, withOffset: 0.0)
        firstNameLabel.autoPinEdge(.top, to: .bottom, of: profilePic, withOffset: 10.0)
        firstNameLabel.font = UIFont.boldSystemFont(ofSize: nameLabelSize)
        
        lastNameLabel.autoSetDimension(.width, toSize: 100)
        lastNameLabel.autoPinEdge(.left, to: .left, of: firstNameLabel, withOffset: 0.0)
        lastNameLabel.autoPinEdge(.top, to: .bottom, of: firstNameLabel, withOffset: 0.0)
        lastNameLabel.font = UIFont.boldSystemFont(ofSize: nameLabelSize)
        
        editProfileButtton.autoPinEdge(.top, to: .top, of: lastNameLabel)
        editProfileButtton.autoPinEdge(.left, to: .left, of: playlistLabel, withOffset: 0.0)
        editProfileButtton.autoSetDimension(.height, toSize: lastNameLabel.frame.height)
        editProfileButtton.autoSetDimension(.width, toSize: 100)
        
        usernameLabel.autoPinEdge(.top, to: .bottom, of: lastNameLabel)
        usernameLabel.autoPinEdge(.left, to: .left, of: lastNameLabel)
        usernameLabel.autoSetDimension(.width, toSize: frame.width)
        
        playlistNumberLabel.autoPinEdge(.top, to: .top, of: profilePic, withOffset: 0.0)
        playlistNumberLabel.autoPinEdge(.left, to: .right, of: profilePic, withOffset: 25.0)
        playlistNumberLabel.autoSetDimension(.width, toSize: 60)
        playlistNumberLabel.font = UIFont.boldSystemFont(ofSize: numberSize)
        
        playlistLabel.autoPinEdge(.left, to: .left, of: playlistNumberLabel)
        playlistLabel.autoPinEdge(.top, to: .bottom, of: playlistNumberLabel, withOffset: 2.5)
        playlistLabel.autoSetDimension(.width, toSize: 60)
        
        followersNumberLabel.autoPinEdge(.bottom, to: .top, of: followersLabel, withOffset: 0.0)
        followersNumberLabel.autoPinEdge(.left, to: .left, of: playlistNumberLabel)
        followersNumberLabel.autoSetDimension(.width, toSize: 60)
        followersNumberLabel.font = UIFont.boldSystemFont(ofSize: numberSize)
        
        followersLabel.autoPinEdge(.bottom, to: .bottom, of: profilePic)
        followersLabel.autoPinEdge(.left, to: .left, of: playlistLabel)
        followersLabel.autoSetDimension(.width, toSize: 60)
        
        followingNumberLabel.autoPinEdge(.left, to: .left, of: followingLabel)
        followingNumberLabel.autoPinEdge(.bottom, to: .top, of: followingLabel, withOffset: 0.0)
        followingNumberLabel.autoSetDimension(.width, toSize: 60)
        followingNumberLabel.font = UIFont.boldSystemFont(ofSize: numberSize)
        
        followingLabel.autoPinEdge(.bottom, to: .bottom, of: profilePic)
        followingLabel.autoPinEdge(.left, to: .right, of: followersLabel, withOffset: 25.0)
        followingLabel.autoSetDimension(.width, toSize: 60)
        
        dividerLineView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        dividerLineView.autoPinEdge(toSuperviewEdge: .left, withInset: 0.0)
        dividerLineView.autoPinEdge(toSuperviewEdge: .right, withInset: 0.0)
        dividerLineView.autoSetDimension(.height, toSize: 1)
        dividerLineView.autoSetDimension(.width, toSize: frame.width)
    }
}
