//
//  SavedViewController.swift
//  Stax
//
//  Created by icbrahimc on 2/12/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController {
    let headerLabel = UILabel.newAutoLayout()
    let headerView = UIView.newAutoLayout()
    let segment = UISegmentedControl.newAutoLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        layout()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SavedViewController {
    func layout() {
        addSubviews()
        
        headerView.autoPinEdge(toSuperviewEdge: .top)
        headerView.autoPinEdge(toSuperviewEdge: .left)
        headerView.autoPinEdge(toSuperviewEdge: .right)
        headerView.autoSetDimensions(to: CGSize(width: view.frame.width, height: 150))
        
        setupHeaderLabel()
        headerView.addSubview(headerLabel)
        headerLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        headerLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
        
        headerView.addSubview(segment)
        segment.insertSegment(withTitle: "Saved", at: 0, animated: true)
        segment.insertSegment(withTitle: "History", at: 1, animated: true)
        segment.autoPinEdge(.top, to: .bottom, of: headerLabel, withOffset: 10.0)
        segment.autoPinEdge(.left, to: .left, of: headerLabel, withOffset: 0.0)
        segment.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)
        segment.autoSetDimension(.width, toSize: view.frame.width)
        segment.autoSetDimension(.height, toSize: 30)
        segment.tintColor = .black
        segment.selectedSegmentIndex = 0
    }
    
    func addSubviews() {
        view.addSubview(headerView)
    }
    
    func setupHeaderLabel() {
        headerLabel.text = "Saved"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 32)
    }
}
