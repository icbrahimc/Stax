//
//  ProfileReusableView.swift
//  Stax
//
//  Created by icbrahimc on 12/24/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

class ProfileReusableView: UICollectionReusableView {
    let nameLabel = UILabel.newAutoLayout()
    
    override func layoutSubviews() {
        addSubview(nameLabel)
        backgroundColor = .white
        nameLabel.autoSetDimension(.height, toSize: 100)
        nameLabel.autoSetDimension(.width, toSize: 100)
        nameLabel.autoPinEdgesToSuperviewEdges()
        nameLabel.text = "Hey"
    }
}
