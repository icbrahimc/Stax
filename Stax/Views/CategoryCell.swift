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
        collectionView.backgroundColor = .blue
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setupViews() {
        backgroundColor = .black
        
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
        return CGSize(width: 150, height: frame.height)
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
    
    func setupViews() {
        print("Setup views")
        backgroundColor = .red
    }
}
