//
//  GridLayout.swift
//  Stax
//
//  Created by icbrahimc on 12/19/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    override var itemSize: CGSize {
        get {
            if let collectionView = collectionView {
                let itemWidth: CGFloat = (collectionView.frame.width/CGFloat(self.numberOfColumns)) - self.minimumInteritemSpacing
                let itemHeight: CGFloat = 200.0
                return CGSize(width: itemWidth, height: itemHeight)
            }
            
            return CGSize(width: 200, height: 200)
        }
        set {
            super.itemSize = newValue
        }
    }

    private var numberOfColumns: Int = 3
    
    init(numberOfColumns: Int) {
        super.init()
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        
        self.numberOfColumns = numberOfColumns
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        if let collectionView = collectionView {
            return collectionView.contentOffset
        }
        return CGPoint.zero
    }
}
