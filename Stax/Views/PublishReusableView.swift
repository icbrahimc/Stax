//
//  PublishReusableView.swift
//  Stax
//
//  Created by icbrahimc on 2/25/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import UIKit

class PublishReusableView: UICollectionReusableView {
    
    var playlist : Playlist? {
        didSet {
            guard let playlist = playlist else { return }
            
            if let title = playlist.title {
                titleLabel.text = title
            }
            
            if let imageURL = playlist.coverArtLink {
                coverImage.loadImageUsingCacheWithUrlString(imageURL)
            }
            
            if let username = playlist.creatorUsername {
                postLabel.text = "Post by: \(username)"
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textColor = UIColor.init(white: 0.2, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 18.0)
        return label
    }()
    
    let coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func layoutSubviews() {
        addSubview(titleLabel)
        addSubview(postLabel)
        addSubview(coverImage)
        
        coverImage.autoPinEdge(toSuperviewEdge: .top, withInset: 7.5)
        coverImage.autoPinEdge(toSuperviewEdge: .left, withInset: 7.5)
        coverImage.autoSetDimension(.height, toSize: frame.height * 0.85)
        coverImage.autoSetDimension(.width, toSize: frame.height * 0.85)
        
        titleLabel.autoPinEdge(.top, to: .top, of: coverImage)
        titleLabel.autoPinEdge(.left, to: .right, of: coverImage, withOffset: 5.0)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 5.0)
        
        postLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        postLabel.autoPinEdge(.left, to: .left, of: titleLabel)
    }
}
