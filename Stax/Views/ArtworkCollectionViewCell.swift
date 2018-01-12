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
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MB3Stacks Vol. VI: Take Care"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    var creatorLabel: UILabel = {
        let label = UILabel()
        label.text = "Curated by: icbrahimc"
        label.font = UIFont.italicSystemFont(ofSize: 12.0)
        return label
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "moon")
        return imageView
    }()
    
    var like: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "heart"), for: UIControlState.normal)
        return button
    }()
    
    let btnOne: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "appleMusic"), for: UIControlState.normal)
        return button
    }()
    
    let btnTwo: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "spotify"), for: UIControlState.normal)
        return button
    }()
    
    let btnThree: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "soundcloud"), for: UIControlState.normal)
        return button
    }()
    
    let btnFour: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "youtubeLogo"), for: UIControlState.normal)
        return button
    }()
    
    func setupViews() {
        addSubview(btnOne)
        addSubview(btnTwo)
        addSubview(btnThree)
        addSubview(btnFour)
        addSubview(like)
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
        
        /* Setup the like button */
        like.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 2.5)
        like.autoPinEdge(.left, to: .left, of: self.contentView, withOffset: 2.5)
        
        /* Setup the btnOne music btn */
        btnOne.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 2.5)
        btnOne.autoPinEdge(.right, to: .right, of: self.contentView, withOffset: -2.5)
        btnOne.autoMatch(.height, to: .height, of: like)
        btnOne.autoMatch(.width, to: .width, of: like)

        /* Setup the btnTwo music btn */
        btnTwo.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 2.5)
        btnTwo.autoPinEdge(.right, to: .left, of: btnOne, withOffset: -2.5)
        btnTwo.autoMatch(.height, to: .height, of: like)
        btnTwo.autoMatch(.width, to: .width, of: like)
        
        /* Setup the btnThree music btn */
        btnThree.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 2.5)
        btnThree.autoPinEdge(.right, to: .left, of: btnTwo, withOffset: -2.5)
        btnThree.autoMatch(.height, to: .height, of: like)
        btnThree.autoMatch(.width, to: .width, of: like)
        
        /* Setup the btnThree music btn */
        btnFour.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 2.5)
        btnFour.autoPinEdge(.right, to: .left, of: btnThree, withOffset: -2.5)
        btnFour.autoMatch(.height, to: .height, of: like)
        btnFour.autoMatch(.width, to: .width, of: like)
    }
}
