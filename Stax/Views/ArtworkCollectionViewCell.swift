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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "moon")
//        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func setupViews() {
        addSubview(imageView)
        
        imageView.autoSetDimensions(to: CGSize(width: frame.width, height: frame.height))
    }
}
