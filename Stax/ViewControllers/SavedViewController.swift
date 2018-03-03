//
//  SavedViewController.swift
//  Stax
//
//  Created by icbrahimc on 2/12/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import UIKit

private let saveIdentifier = "SaveCell"

class SavedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var cellSpacing: CGFloat = 35
    
    let dividerView = UIView.newAutoLayout()
    let headerLabel = UILabel.newAutoLayout()
    let headerView = UIView.newAutoLayout()
    let segment = UISegmentedControl.newAutoLayout()
    
    let savedPlaylistCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        layout()
        
        savedPlaylistCollectionView.dataSource = self
        savedPlaylistCollectionView.delegate = self
        savedPlaylistCollectionView.register(ArtworkCollectionViewCell.self, forCellWithReuseIdentifier: saveIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: saveIdentifier, for: indexPath) as! ArtworkCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 3 * cellSpacing) / 2
        let height = width + 130
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, cellSpacing, 0, cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension SavedViewController {
    func layout() {
        addSubviews()
        
        headerView.autoPinEdge(toSuperviewEdge: .top)
        headerView.autoPinEdge(toSuperviewEdge: .left)
        headerView.autoPinEdge(toSuperviewEdge: .right)
        headerView.autoSetDimensions(to: CGSize(width: view.frame.width, height: 135))
        
        setupHeaderLabel()
        headerView.addSubview(headerLabel)
        headerLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        headerLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
        
        headerView.addSubview(segment)
        segment.insertSegment(withTitle: "Saved", at: 0, animated: true)
        segment.insertSegment(withTitle: "History", at: 1, animated: true)
        segment.autoPinEdge(.top, to: .bottom, of: headerLabel, withOffset: 5.0)
        segment.autoPinEdge(.left, to: .left, of: headerLabel, withOffset: 0.0)
        segment.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)
        segment.autoSetDimension(.width, toSize: view.frame.width)
        segment.autoSetDimension(.height, toSize: 30)
        segment.tintColor = .black
        segment.selectedSegmentIndex = 0
        
        setupDividerView()
        headerView.addSubview(dividerView)
        dividerView.autoSetDimension(.width, toSize: view.frame.width)
        dividerView.autoSetDimension(.height, toSize: 1.0)
        dividerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 1.0)
        dividerView.autoPinEdge(toSuperviewEdge: .left, withInset: 0.0)
        dividerView.autoPinEdge(toSuperviewEdge: .right, withInset: 0.0)
        
        savedPlaylistCollectionView.autoPinEdge(toSuperviewEdge: .left, withInset: 0.0)
        savedPlaylistCollectionView.autoPinEdge(toSuperviewEdge: .right, withInset: 0.0)
        savedPlaylistCollectionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0.0)
        savedPlaylistCollectionView.autoPinEdge(.top, to: .bottom, of: headerView, withOffset: 0.0)
    }
    
    func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(savedPlaylistCollectionView)
    }
    
    func setupHeaderLabel() {
        headerLabel.text = "Saved"
        headerLabel.font = UIFont.init().heavyBlackFont(ofSize: 32.0)
    }
    
    func setupDividerView() {
        dividerView.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
    }
}
