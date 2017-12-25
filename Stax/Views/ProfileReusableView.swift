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
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@icbrahimc"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize - 2)
        return label
    }()
    
    let dividerLineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let profilePic: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "moon")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 37.5
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let playlistsLabel: UILabel = {
        let label = UILabel()
        label.text = "Playlists: 9000"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override func layoutSubviews() {
        addSubview(profilePic)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(dividerLineView)
        addSubview(playlistsLabel)
        
        backgroundColor = .white
        profilePic.autoSetDimension(.height, toSize: 75)
        profilePic.autoSetDimension(.width, toSize: 75)
        profilePic.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        profilePic.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        
        nameLabel.autoSetDimension(.width, toSize: frame.width)
        nameLabel.autoPinEdge(.left, to: .right, of: profilePic, withOffset: 10)
        nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        
        usernameLabel.autoSetDimension(.width, toSize: frame.width)
        usernameLabel.autoPinEdge(.left, to: .right, of: profilePic, withOffset: 10)
        usernameLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 5)
        
        playlistsLabel.autoSetDimension(.width, toSize: frame.width)
        playlistsLabel.autoPinEdge(.left, to: .right, of: profilePic, withOffset: 10)
        playlistsLabel.autoPinEdge(.top, to: .bottom, of: usernameLabel, withOffset: 5)
        
        dividerLineView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        dividerLineView.autoPinEdge(toSuperviewEdge: .left, withInset: 14)
        dividerLineView.autoPinEdge(toSuperviewEdge: .right, withInset: 14)
        dividerLineView.autoSetDimension(.height, toSize: 1)
        dividerLineView.autoSetDimension(.width, toSize: frame.width)
    }
}
