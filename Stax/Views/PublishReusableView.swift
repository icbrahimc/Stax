//
//  PublishReusableView.swift
//  Stax
//
//  Created by icbrahimc on 2/25/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import UIKit

class PublishReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MB3Stacks"
        return label
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.text = "Post by: icbrahimc"
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
        
        coverImage.autoPinEdge(toSuperviewEdge: .top, withInset: 5.0)
        coverImage.autoPinEdge(toSuperviewEdge: .left, withInset: 5.0)
        coverImage.autoSetDimension(.height, toSize: frame.height * 0.9)
        coverImage.autoSetDimension(.width, toSize: frame.height * 0.9)
        
        titleLabel.autoPinEdge(.top, to: .top, of: coverImage)
        titleLabel.autoPinEdge(.left, to: .right, of: coverImage, withOffset: 5.0)
        
        postLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        postLabel.autoPinEdge(.left, to: .left, of: titleLabel)
    }
}
