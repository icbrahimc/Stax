//
//  UsernameViewController.swift
//  Stax
//
//  Created by icbrahimc on 12/26/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

class UsernameViewController: UIViewController, UITextFieldDelegate {
    let usernameField = UITextField.newAutoLayout()
    let submitButton = UIButton(type: UIButtonType.roundedRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Username"
    
        navigationItem.hidesBackButton = true
        layout()
        
        submitButton.alpha = 0.5
        submitButton.isEnabled = false
        
        usernameField.delegate = self
        
        usernameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text.count < 3 {
                UIView.animate(withDuration: 0.5, animations: {
                    self.submitButton.isEnabled = false
                    self.submitButton.alpha = 0.5
                })
            } else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.submitButton.isEnabled = true
                    self.submitButton.alpha = 1.0
                })
            }
        }
    }
    
    /* Segue to assist with onboarding vc. */
    func customSegue() {
        if let navVC = navigationController as? OnboardingNavigationController {
            ProfileManager.sharedInstance.fetchUserInfo()
            if let user = ProfileManager.sharedInstance.user {
                if user.username == "" {
                    navVC.statisfyRequirement(.signIn)
                    navVC.pushNextPhase()
                }
            }
        }
    }
}

extension UsernameViewController {
    func layout() {
        setupViews()
        
        usernameFieldSetup()
        usernameField.autoSetDimension(.height, toSize: 45)
        usernameField.autoSetDimension(.width, toSize: view.frame.width - 50)
        usernameField.autoPinEdge(toSuperviewEdge: .top, withInset: 70)
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
