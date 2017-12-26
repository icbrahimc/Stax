//
//  UsernameViewController.swift
//  Stax
//
//  Created by icbrahimc on 12/26/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

class UsernameViewController: UIViewController {
    let usernameField = UITextField.newAutoLayout()
    let submitButton = UIButton.newAutoLayout()
    
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

extension UsernameViewController {
    func layout() {
        setupViews()
        usernameField.autoSetDimension(.height, toSize: 45)
        usernameField.autoSetDimension(.width, toSize: view.frame.width - 50)
        usernameField.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        usernameField.autoAlignAxis(toSuperviewMarginAxis: .vertical)
    }
    
    func setupViews() {
        view.addSubview(usernameField)
    }
}
