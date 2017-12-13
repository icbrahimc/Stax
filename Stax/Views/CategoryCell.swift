//
//  CategoryCell.swift
//  Stax
//
//  Created by icbrahimc on 12/13/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let reuseIdentifierMusic = "musicCell"

class CategoryCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let playlistCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setupViews() {
        backgroundColor = .white
        
        playlistCollectionView.dataSource = self
        playlistCollectionView.delegate = self
        
        playlistCollectionView.register(MusicCardCell.self, forCellWithReuseIdentifier: reuseIdentifierMusic)
        addSubview(playlistCollectionView)
        
        playlistCollectionView.autoPinEdgesToSuperviewEdges()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierMusic, for: indexPath) as! MusicCardCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}

class MusicCardCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moon")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MB3Stacks Vol. VI: Moon Care"
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 2
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Moonboyz3000"
        return label
    }()
    
    func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(authorLabel)

        imageView.autoSetDimensions(to: CGSize(width: frame.width, height: frame.width))
        
        titleLabel.autoPinEdge(.top, to: .bottom, of: imageView)
        titleLabel.autoSetDimension(.width, toSize: frame.width)
        
        authorLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        authorLabel.autoSetDimension(.width, toSize: frame.width)
    }
}
