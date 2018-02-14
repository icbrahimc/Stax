//
//  SpotifyTableViewCell.swift
//  Stax
//
//  Created by icbrahimc on 2/14/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import UIKit

class SpotifyTableViewCell: UITableViewCell {
    var playlist : Playlist? {
        didSet {
            guard let playlist = playlist else { return }
            
            if let title = playlist.title {
                titleLabel.text = title
            }
            
            if let imageURL = playlist.coverArtLink {
                artwork.loadImageUsingCacheWithUrlString(imageURL)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "spotify")
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    let artwork: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moon")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MB3Stacks Vol. VI: Moon Care"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()

    func setupViews() {
        addSubview(artwork)
        addSubview(titleLabel)
        
        artwork.autoPinEdge(toSuperviewEdge: .left, withInset: 5.0)
        artwork.autoAlignAxis(toSuperviewAxis: .horizontal)
        artwork.autoSetDimension(.height, toSize: 90)
        artwork.autoSetDimension(.width, toSize: 90)
        
        titleLabel.autoPinEdge(.left, to: .right, of: artwork, withOffset: 5.0)
        titleLabel.autoSetDimension(.width, toSize: frame.width)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
}
