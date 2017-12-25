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
    
    let profilePic: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "moon")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25.0
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func layoutSubviews() {
        addSubview(profilePic)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        
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
    }
}
