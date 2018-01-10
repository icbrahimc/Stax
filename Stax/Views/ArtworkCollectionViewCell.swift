//
//  ArtworkCollectionViewCell.swift
//  Stax
//
//  Created by icbrahimc on 12/18/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

class ArtworkCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MB3Stacks Vol. VI: Take Care"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    let creatorLabel: UILabel = {
        let label = UILabel()
        label.text = "Curated by: icbrahimc"
        label.font = UIFont.italicSystemFont(ofSize: 12.0)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "moon")
        return imageView
    }()
    
    func setupViews() {
        addSubview(creatorLabel)
        addSubview(titleLabel)
        addSubview(imageView)
        
        /* Setup the imageview */
        imageView.autoSetDimensions(to: CGSize(width: frame.width, height: frame.height * 0.85))
        imageView.autoAlignAxis(toSuperviewAxis: .vertical)
        imageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        /* Setup the title label */
        titleLabel.autoSetDimension(.width, toSize: frame.width)
        titleLabel.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 5)
        titleLabel.autoPinEdge(.left, to: .left, of: self.contentView, withOffset: 5)
        
        /* Setup the creator label */
        creatorLabel.autoSetDimension(.width, toSize: frame.width)
        creatorLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 1.5)
        creatorLabel.autoPinEdge(.left, to: .left, of: titleLabel)
    }
}
