//
//  ViewController.swift
//  Stax
//
//  Created by icbrahimc on 12/5/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Firebase
import GoogleSignIn
import UIKit

class ViewController: UIViewController, GIDSignInUIDelegate {
    let elementSize: CGSize = CGSize(width: 300, height: 45)
    let facebookSignInBtn = UIButton(type: UIButtonType.roundedRect)
    let googleSignInBtn = UIButton(type: UIButtonType.roundedRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        layout()
//        GIDSignIn.sharedInstance().signIn()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    func layout() {
        addSubviews()
        
        setupFBButton()
        facebookSignInBtn.autoSetDimensions(to: elementSize)
        facebookSignInBtn.autoAlignAxis(toSuperviewAxis: .vertical)
        facebookSignInBtn.autoPinEdge(toSuperviewEdge: .bottom, withInset: 60)
        
        setupGButton()
        googleSignInBtn.autoSetDimensions(to: elementSize)
        googleSignInBtn.autoAlignAxis(toSuperviewAxis: .vertical)
        googleSignInBtn.autoPinEdge(.bottom, to: .top, of: facebookSignInBtn)
    }
    
    func addSubviews() {
        view.addSubview(facebookSignInBtn)
        view.addSubview(googleSignInBtn)
    }
    
    func setupFBButton() {
        facebookSignInBtn.backgroundColor = UIColor(red:58.0/255.0, green:89.0/255.0, blue:152.0/255.0, alpha:1.0)
        facebookSignInBtn.setTitle("Continue with Facebook", for: .normal)
        facebookSignInBtn.setTitleColor(.white, for: .normal)
        facebookSignInBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func setupGButton() {
        googleSignInBtn.backgroundColor = UIColor(red:211.0/255.0, green:72.0/255.0, blue:54.0/255.0, alpha:1.0)
        googleSignInBtn.setTitle("Continue with Google", for: .normal)
        googleSignInBtn.setTitleColor(.white, for: .normal)
        googleSignInBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
}
