//
//  AddPlaylistViewController.swift
//  Stax
//
//  Created by icbrahimc on 1/3/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import UIKit

class AddPlaylistViewController: UIViewController {
    let appleMusicBtn = UIButton.newAutoLayout()
    let spotifyBtn = UIButton.newAutoLayout()
    let formDivider = FormDivider.newAutoLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
}

extension AddPlaylistViewController {
    func layout () {
        addSubviews()
        
        /* Layout for the form dividers */
        formDivider.autoAlignAxis(toSuperviewAxis: .vertical)
        formDivider.autoAlignAxis(toSuperviewAxis: .horizontal)
        formDivider.autoSetDimensions(to: CGSize(width: view.frame.width, height: 45))
        
        /* Layout for the apple music button */
        let appleMusicImage = UIImage(named: "appleMusic")
        appleMusicBtn.setImage(appleMusicImage, for: UIControlState.normal)
        appleMusicBtn.autoAlignAxis(toSuperviewAxis: .vertical)
        appleMusicBtn.autoPinEdge(.bottom, to: .top, of: formDivider, withOffset: -20)
        appleMusicBtn.autoSetDimensions(to: CGSize(width: view.frame.width * 0.4, height: view.frame.height * 0.2))
        
        /* Layout for the spotify music button */
        let spotifyImage = UIImage(named: "spotify")
        spotifyBtn.setImage(spotifyImage, for: UIControlState.normal)
        spotifyBtn.autoAlignAxis(toSuperviewAxis: .vertical)
        spotifyBtn.autoPinEdge(.top, to: .bottom, of: formDivider, withOffset: 20)
        spotifyBtn.autoSetDimensions(to: CGSize(width: view.frame.width * 0.3, height: view.frame.height * 0.2))
        
    }
    
    func addSubviews() {
        print("Add subviews")
        view.addSubview(formDivider)
        view.addSubview(appleMusicBtn)
        view.addSubview(spotifyBtn)
    }
}
