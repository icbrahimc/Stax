//
//  ArtworkCollectionViewCell.swift
//  Stax
//
//  Created by icbrahimc on 12/18/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

class ArtworkCollectionViewCell: UICollectionViewCell {
    var playlist : Playlist? {
        didSet {
            guard let playlist = playlist else { return }
            
            if let title = playlist.title {
                titleLabel.text = title
            }
            
            if let creatorUsername = playlist.creatorUsername {
                creatorLabel.text = "Curated by: \(creatorUsername)"
            }
            
            if let imageURL = playlist.coverArtLink {
                imageView.loadImageUsingCacheWithUrlString(imageURL)
            }
            
            if let playlistID = playlist.id {
                if ProfileManager.sharedInstance.checkIfLikeExists(playlistID) {
                    like.alpha = 1.0
                } else {
                    like.alpha = 0.5
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = UIColor.white
        
        like.addTarget(self, action: #selector(pressLikeBTN), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MB3Stacks Vol. VI: Take Care"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    var creatorLabel: UILabel = {
        let label = UILabel()
        label.text = "Posted by: icbrahimc"
        label.font = UIFont.italicSystemFont(ofSize: 12.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.alpha = 0.5
        return label
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "moon")
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "save"), for: UIControlState.normal)
        return button
    }()
    
    var like: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "heart"), for: UIControlState.normal)
        return button
    }()
    
    func setupViews() {
        addSubview(creatorLabel)
        addSubview(titleLabel)
        addSubview(imageView)
        imageView.addSubview(saveButton)
        
        /* Setup the imageview */
        imageView.autoSetDimensions(to: CGSize(width: frame.width, height: frame.height * 0.70))
        imageView.autoAlignAxis(toSuperviewAxis: .vertical)
        imageView.autoPinEdge(toSuperviewEdge: .top, withInset: 10.0)
        
        /* Setup the title label */
        titleLabel.autoSetDimension(.width, toSize: frame.width)
        titleLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 15.0)
        titleLabel.autoPinEdge(.left, to: .left, of: imageView, withOffset: 10.0)
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        /* Setup the creator label */
        creatorLabel.autoSetDimension(.width, toSize: frame.width)
        creatorLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 1.5)
        creatorLabel.autoPinEdge(.left, to: .left, of: titleLabel)
        
        /* Setup the button label */
        saveButton.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        saveButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        saveButton.autoSetDimension(.height, toSize: frame.height * 0.15)
        saveButton.autoSetDimension(.width, toSize: frame.height * 0.15)
    }
    
    @objc func pressLikeBTN() {
        if ProfileManager.sharedInstance.checkIfLikeExists((playlist?.id)!) {
            UIView.animate(withDuration: 0.2, animations: {
                self.like.alpha = 0.5
            }, completion: { (success) in
                if success {
                    ProfileManager.sharedInstance.unlikePlaylist(self.playlist!, completion: {})
                }
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.like.alpha = 1.0
            }, completion: { (success) in
                if success {
                    ProfileManager.sharedInstance.likePlaylist(self.playlist!, completion: {})
                }
            })
        }
    }
}
