//
//  ProfileReusableView.swift
//  Stax
//
//  Created by icbrahimc on 12/24/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

class ProfileReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ibrahim Conteh"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()
    
    let playlistNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "15"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let playlistLabel: UILabel = {
        let label = UILabel()
        label.text = "playlists"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = UIColor.init(white: 0.4, alpha: 0.6)
        return label
    }()
    
    let followersNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "640"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.text = "followers"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = UIColor.init(white: 0.4, alpha: 0.6)
        return label
    }()
    
    let followingNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "780"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.text = "following"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = UIColor.init(white: 0.4, alpha: 0.6)
        return label
    }()
    
    let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ibrahim"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Conteh"
        label.font = UIFont.boldSystemFont(ofSize: 22)
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
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.black, for: .normal)
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
        firstNameLabel.autoPinEdge(.left, to: .left, of: profilePic, withOffset: 5.0)
        firstNameLabel.autoPinEdge(.top, to: .bottom, of: profilePic, withOffset: 10.0)
        
        lastNameLabel.autoSetDimension(.width, toSize: 100)
        lastNameLabel.autoPinEdge(.left, to: .left, of: firstNameLabel, withOffset: 0.0)
        lastNameLabel.autoPinEdge(.top, to: .bottom, of: firstNameLabel, withOffset: 0.0)
        
        editProfileButtton.autoPinEdge(.top, to: .top, of: lastNameLabel)
        editProfileButtton.autoPinEdge(.left, to: .left, of: playlistLabel, withOffset: 0.0)
        editProfileButtton.autoSetDimension(.height, toSize: lastNameLabel.frame.height)
        editProfileButtton.autoSetDimension(.width, toSize: 100)
        editProfileButtton.backgroundColor = .black
        
        usernameLabel.autoPinEdge(.top, to: .bottom, of: lastNameLabel)
        usernameLabel.autoPinEdge(.left, to: .left, of: lastNameLabel)
        usernameLabel.autoSetDimension(.width, toSize: frame.width)
        
        playlistNumberLabel.autoPinEdge(.top, to: .top, of: profilePic, withOffset: 0.0)
        playlistNumberLabel.autoPinEdge(.left, to: .right, of: profilePic, withOffset: 25.0)
        playlistNumberLabel.autoSetDimension(.width, toSize: 60)
        
        playlistLabel.autoPinEdge(.left, to: .left, of: playlistNumberLabel)
        playlistLabel.autoPinEdge(.top, to: .bottom, of: playlistNumberLabel, withOffset: 2.5)
        playlistLabel.autoSetDimension(.width, toSize: 60)
        
        followersNumberLabel.autoPinEdge(.bottom, to: .top, of: followersLabel, withOffset: 0.0)
        followersNumberLabel.autoPinEdge(.left, to: .left, of: playlistNumberLabel)
        followersNumberLabel.autoSetDimension(.width, toSize: 60)
        
        followersLabel.autoPinEdge(.bottom, to: .bottom, of: profilePic)
        followersLabel.autoPinEdge(.left, to: .left, of: playlistLabel)
        followersLabel.autoSetDimension(.width, toSize: 60)
        
        followingNumberLabel.autoPinEdge(.left, to: .left, of: followingLabel)
        followingNumberLabel.autoPinEdge(.bottom, to: .top, of: followingLabel, withOffset: 0.0)
        followingNumberLabel.autoSetDimension(.width, toSize: 60)
        
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
