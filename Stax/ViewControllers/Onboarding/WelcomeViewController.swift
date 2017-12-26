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
import UIKit

class WelcomeViewController: UIViewController, GIDSignInUIDelegate {
    let logoDesign = UIImageView.newAutoLayout()
    let tagLineLabel = UILabel.newAutoLayout()
    let elementSize: CGSize = CGSize(width: 300, height: 45)
    let formDivider = FormDivider.newAutoLayout()
    let facebookSignInBtn = UIButton(type: UIButtonType.roundedRect)
    let googleSignInBtn = UIButton(type: UIButtonType.roundedRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        layout()
        
        facebookSignInBtn.addTarget(self, action: #selector(WelcomeViewController.facebookSignIn), for: .touchUpInside)
        googleSignInBtn.addTarget(self, action: #selector(WelcomeViewController.googleSignIn), for: .touchUpInside)
        GIDSignIn.sharedInstance().uiDelegate = self as GIDSignInUIDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func facebookSignIn() {
        print("Facebook")
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self, handler: {
            (result, err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            // Get the access token and authenticate.
            let accessToken = FBSDKAccessToken.current()
            guard let accessTokenString = accessToken?.tokenString else {
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                // If the user is signed in and authenticated, segue to a new view controller.
                if let newUser = user {
                    
                    let graphPath = "me"
                    let parameters = ["fields": "id, email, name, first_name, last_name, picture"]
                    let graphRequest = FBSDKGraphRequest(graphPath: graphPath, parameters: parameters)
                    let connection = FBSDKGraphRequestConnection()
                    
                    connection.add(graphRequest, completionHandler: { (connection, result, error) in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        // Todo(icbrahimc): add custom segue when it makes complete sense.
                    })
                    connection.start()
                }
            }
        })
        
    }
    
    @objc func googleSignIn() {
        print("Google")
        GIDSignIn.sharedInstance().signIn()
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()) {
            customSegue()
        }
    }
    
    /* Segue to assist with onboarding vc. */
    func customSegue() {
        if let navVC = navigationController as? OnboardingNavigationController {
            navVC.statisfyRequirement(.signIn)
            navVC.pushNextPhase()
        }
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
