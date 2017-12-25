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

class WelcomeViewController: UIViewController, GIDSignInUIDelegate {
    let logoDesign = UIImageView.newAutoLayout()
    let tagLineLabel = UILabel.newAutoLayout()
    let elementSize: CGSize = CGSize(width: 300, height: 45)
    let formDivider = FormDivider.newAutoLayout()
    let facebookSignInBtn = UIButton(type: UIButtonType.roundedRect)
    let googleSignInBtn = UIButton(type: UIButtonType.roundedRect)
    var navControllers: [UINavigationController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        layout()
        
        // Setup nav controllers for the tab controller.
        // TODO(icbrahimc): Move this to a function or encapsulate this into a class.
3
        let artworkLayout = UICollectionViewFlowLayout()
        let artworkVC = ArtworkCollectionViewController(collectionViewLayout: artworkLayout)
        let navVCArtwork = UINavigationController(rootViewController: artworkVC)
        navVCArtwork.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        
        let profileLayout = UICollectionViewFlowLayout()
        let profileVC = ProfileViewController(collectionViewLayout: profileLayout)
        let navVCProf = UINavigationController(rootViewController: profileVC)
        navVCProf.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        navControllers.append(navVCArtwork)
        navControllers.append(navVCProf)
        
        facebookSignInBtn.addTarget(self, action: #selector(WelcomeViewController.facebookSignIn), for: .touchUpInside)
        googleSignInBtn.addTarget(self, action: #selector(WelcomeViewController.googleSignIn), for: .touchUpInside)
//        GIDSignIn.sharedInstance().signIn()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func facebookSignIn() {
        print("Facebook")
        let tabController = UITabBarController()
        tabController.viewControllers = navControllers
        self.navigationController?.pushViewController(tabController, animated: true)
    }
    
    @objc func googleSignIn() {
        print("Google")
        let tabController = UITabBarController()
        tabController.viewControllers = navControllers
        self.navigationController?.pushViewController(tabController, animated: true)
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
