//
//  ViewController.swift
//  Stax
//
//  Created by icbrahimc on 12/5/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import TTTAttributedLabel
import UIKit

class WelcomeViewController: OnboardingViewController, GIDSignInUIDelegate, TTTAttributedLabelDelegate {
    let logoDesign = UIImageView.newAutoLayout()
    let tagLineLabel = UILabel.newAutoLayout()
    let elementSize: CGSize = CGSize(width: 300, height: 45)
    let formDivider = FormDivider.newAutoLayout()
    let facebookSignInBtn = UIButton(type: UIButtonType.roundedRect)
    let googleSignInBtn = UIButton(type: UIButtonType.roundedRect)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        layout()

        facebookSignInBtn.addTarget(self, action: #selector(WelcomeViewController.facebookSignIn), for: .touchUpInside)
        googleSignInBtn.addTarget(self, action: #selector(WelcomeViewController.googleSignIn), for: .touchUpInside)
        GIDSignIn.sharedInstance().uiDelegate = self as GIDSignInUIDelegate
        navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension WelcomeViewController {
    func layout() {
        addSubviews()
        
        logoDesign.image = #imageLiteral(resourceName: "plugDesign")
        logoDesign.autoAlignAxis(toSuperviewAxis: .vertical)
        logoDesign.autoSetDimensions(to: CGSize(width: 150, height: 75))
        logoDesign.autoPinEdge(toSuperviewEdge: .top, withInset: 175)

        setupTagLabel()
        tagLineLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        tagLineLabel.autoPinEdge(.top, to: .bottom, of: logoDesign, withOffset: 0)

        setupFBButton()
        facebookSignInBtn.autoSetDimensions(to: elementSize)
        facebookSignInBtn.autoAlignAxis(toSuperviewAxis: .vertical)
        facebookSignInBtn.autoPinEdge(toSuperviewEdge: .bottom, withInset: 60)

        setupGButton()
        googleSignInBtn.autoSetDimensions(to: elementSize)
        googleSignInBtn.autoAlignAxis(toSuperviewAxis: .vertical)
        googleSignInBtn.autoPinEdge(.bottom, to: .top, of: formDivider, withOffset: -10)

        formDivider.autoSetDimensions(to: elementSize)
        formDivider.autoAlignAxis(toSuperviewAxis: .vertical)
        formDivider.autoPinEdge(.bottom, to: .top, of: facebookSignInBtn, withOffset: -10)
    }

    func addSubviews() {
        view.addSubview(tagLineLabel)
        view.addSubview(logoDesign)
        view.addSubview(facebookSignInBtn)
        view.addSubview(googleSignInBtn)
        view.addSubview(formDivider)
    }

    func setupTagLabel() {
        tagLineLabel.text = "Collaborate. Curate. Listen."
    }

    func setupFBButton() {
        facebookSignInBtn.backgroundColor = UIColor(red:58.0/255.0, green:89.0/255.0, blue:152.0/255.0, alpha:1.0)
        facebookSignInBtn.setTitle("Continue with Facebook", for: .normal)
        facebookSignInBtn.setTitleColor(.white, for: .normal)
        facebookSignInBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        facebookSignInBtn.layer.cornerRadius = 5.0
        facebookSignInBtn.layer.masksToBounds = true
    }

    func setupGButton() {
        googleSignInBtn.backgroundColor = UIColor(red:211.0/255.0, green:72.0/255.0, blue:54.0/255.0, alpha:1.0)
        googleSignInBtn.setTitle("Continue with Google", for: .normal)
        googleSignInBtn.setTitleColor(.white, for: .normal)
        googleSignInBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        googleSignInBtn.layer.cornerRadius = 5.0
        googleSignInBtn.layer.masksToBounds = true
    }
}
