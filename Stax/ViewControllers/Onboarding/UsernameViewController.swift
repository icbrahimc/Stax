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
    let submitButton = UIButton(type: UIButtonType.roundedRect)
    
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
        
        usernameFieldSetup()
        usernameField.autoSetDimension(.height, toSize: 45)
        usernameField.autoSetDimension(.width, toSize: view.frame.width - 50)
        usernameField.autoPinEdge(toSuperviewEdge: .top, withInset: 30)
        usernameField.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        
        submitButtonSetup()
        submitButton.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        submitButton.autoSetDimension(.height, toSize: 45)
        submitButton.autoSetDimension(.width, toSize: view.frame.width / 2)
        submitButton.autoPinEdge(.top, to: .bottom, of: usernameField, withOffset: 10)
    }
    
    func usernameFieldSetup() {
        usernameField.borderStyle = .roundedRect
        usernameField.layer.cornerRadius = 10.0
        usernameField.layer.borderWidth = 1.0
        usernameField.layer.borderColor = UIColor.black.cgColor
    }
    
    func submitButtonSetup() {
        submitButton.backgroundColor = .black
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        submitButton.layer.cornerRadius = 5.0
        submitButton.layer.masksToBounds = true
    }
    
    func setupViews() {
        view.addSubview(usernameField)
        view.addSubview(submitButton)
    }
}
