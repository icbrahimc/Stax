//
//  CategoryCell.swift
//  Stax
//
//  Created by icbrahimc on 12/13/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let playlistCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .blue
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setupViews() {
        backgroundColor = .black
        
        addSubview(playlistCollectionView)
        
        playlistCollectionView.autoPinEdgesToSuperviewEdges()
        
    }
}
