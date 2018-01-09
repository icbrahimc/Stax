//
//  OnboardingNavigationController.swift
//  Stax
//
//  Created by icbrahimc on 12/26/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import UIKit

enum OnboardRequirement {
    case signIn, username
}

class OnboardingNavigationController: UINavigationController {
    fileprivate var statisfiedRequirements: Set<OnboardRequirement> = Set()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init() {
        let welcomeController = WelcomeViewController()
        super.init(rootViewController: welcomeController)
    }
    
    func reset() {
        statisfiedRequirements = Set()
    }
    
    func statisfyRequirement(_ requirement: OnboardRequirement) {
        statisfiedRequirements.insert(requirement)
    }
    
    func getNextViewController() -> UIViewController? {
        if !statisfiedRequirements.contains(.signIn) {
            return WelcomeViewController()
        }
        
        if !statisfiedRequirements.contains(.username) {
            return UsernameViewController()
        }
        
        return nil
    }
    
    func pushNextPhase() {
        guard let viewController = getNextViewController() else {
            reset()
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "onboardingEnded"), object: nil))
            return
        }
        
        pushViewController(viewController, animated: true)
    }
}
