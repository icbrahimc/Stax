//
//  TrackViewCell.swift
//  Stax
//
//  Created by icbrahimc on 2/25/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import UIKit

class TrackViewCell: UICollectionViewCell {
    var track : Song? {
        didSet {
            guard let track = track else { return }
            
            if let title = track.albumName {
                titleLabel.text = title
            }
            
            if let artist = track.artistName {
                artistLabel.text = artist
            }
        }
    }
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
        label.font = UIFont.init().mediumFont(ofSize: 15.0)
        label.text = "Girls Love Beyonce"
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init().lightFont(ofSize: 15.0)
        label.text = "Drake"
        label.textColor = UIColor.init().fontGrey()
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
