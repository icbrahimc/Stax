//
//  FeedReusableView.swift
//  
//
//  Created by icbrahimc on 2/5/18.
//

import UIKit

class FeedReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    let playlistLabel: UILabel = {
        let label = UILabel()
        label.text = "PLAYLISTS"
        label.font = UIFont.boldSystemFont(ofSize: 32.0)
        return label
    }()
    
    let toFollowLabel: UILabel = {
        let label = UILabel()
        label.text = "TO DISCOVER"
        label.font = UIFont.boldSystemFont(ofSize: 32.0)
        return label
    }()
    
    func setupViews() {
        addSubview(playlistLabel)
        addSubview(toFollowLabel)
        addSubview(icon)
        
        playlistLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 15.0)
        playlistLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
        playlistLabel.autoSetDimension(.width, toSize: frame.width)
        
        toFollowLabel.autoPinEdge(.top, to: .bottom, of: playlistLabel, withOffset: 5.0)
        toFollowLabel.autoPinEdge(.left, to: .left, of: playlistLabel, withOffset: 0.0)
        
        icon.autoAlignAxis(toSuperviewAxis: .horizontal)
        icon.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
        icon.autoSetDimension(.height, toSize: 65)
        icon.autoSetDimension(.width, toSize: 65)
    }
}
