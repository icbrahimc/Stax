//
//  AddPlaylistCell.swift
//  Stax
//
//  Created by icbrahimc on 2/2/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import UIKit

private let addIdentifier = "addCell"

class AddPlaylistCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let addCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let dividerLineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let dividerLineViewOne: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    func setupViews() {
        addSubview(dividerLineView)
        addSubview(dividerLineViewOne)
        addSubview(addCollectionView)
        
        addCollectionView.dataSource = self
        addCollectionView.delegate = self
        addCollectionView.register(MusicServiceCell.self, forCellWithReuseIdentifier: addIdentifier)
        addCollectionView.autoPinEdge(toSuperviewEdge: .top, withInset: 5.0)
        addCollectionView.autoPinEdge(toSuperviewEdge: .left)
        addCollectionView.autoPinEdge(toSuperviewEdge: .right)
        addCollectionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5.0)
        
        dividerLineViewOne.autoPinEdge(.bottom, to: .top, of: addCollectionView)
        dividerLineViewOne.autoPinEdge(toSuperviewEdge: .left)
        dividerLineViewOne.autoPinEdge(toSuperviewEdge: .right)
        dividerLineViewOne.autoSetDimension(.height, toSize: 1)
        dividerLineViewOne.autoSetDimension(.width, toSize: frame.width)
        
        dividerLineView.autoPinEdge(.top, to: .bottom, of: addCollectionView)
        dividerLineView.autoPinEdge(toSuperviewEdge: .left)
        dividerLineView.autoPinEdge(toSuperviewEdge: .right)
        dividerLineView.autoSetDimension(.height, toSize: 1)
        dividerLineView.autoSetDimension(.width, toSize: frame.width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addIdentifier, for: indexPath) as! MusicServiceCell
            cell.musicServiceLabel.text = "Apple Music"
            cell.iconImage.image = UIImage(named: "apple_music_logo")
            return cell
        
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addIdentifier, for: indexPath) as! MusicServiceCell
            cell.musicServiceLabel.text = "Spotify"
            cell.iconImage.image = UIImage(named: "spotify_logo")
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addIdentifier, for: indexPath) as! MusicServiceCell

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("Apple Music")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TapAppleButton"), object: nil)
        case 1:
            print("Spotify")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TapSpotifyButton"), object: nil)
        default:
            print("None")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2, height: frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}

class MusicServiceCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "apple_music_logo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let musicServiceLabel: UILabel = {
        let label = UILabel()
        label.text = "Apple Music"
//        label.font = UIFont.init().defaultFont(ofSize: 15.0)
        return label
    }()
    
    func setupViews() {
        addSubview(iconImage)
        addSubview(musicServiceLabel)
        
        iconImage.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
        iconImage.autoAlignAxis(toSuperviewAxis: .horizontal)
        iconImage.autoSetDimensions(to: CGSize(width: frame.height * 0.75, height: frame.height * 0.75))
        
        musicServiceLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        musicServiceLabel.autoPinEdge(.left, to: .right, of: iconImage, withOffset: 10.0)
    }
}
