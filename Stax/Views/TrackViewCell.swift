//
//  TrackViewCell.swift
//  Stax
//
//  Created by icbrahimc on 2/25/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import UIKit

class TrackViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Girls Love Beyonce"
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.text = "Drake"
        return label
    }()
    
    let dividerView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(artistLabel)
        addSubview(dividerView)
        
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 5.0)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 5.0)
        
        artistLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        artistLabel.autoPinEdge(.left, to: .left, of: titleLabel)
        
        dividerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0.0)
        dividerView.autoPinEdge(toSuperviewEdge: .left, withInset: 1.0)
        dividerView.autoPinEdge(toSuperviewEdge: .right, withInset: 1.0)
        dividerView.autoSetDimension(.height, toSize: 1.0)
        dividerView.autoSetDimension(.width, toSize: frame.width)
    }
}
