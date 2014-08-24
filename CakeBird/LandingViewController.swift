//
//  LandingViewController.swift
//  CakeBird
//
//  Created by Rhett Rogers on 8/16/14.
//  Copyright (c) 2014 Lyokotech. All rights reserved.
//

import UIKit
import Accounts
import SwifteriOS

class LandingViewController: SuperViewController {
    
    override func viewDidLoad() {
        loginToTwitter()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginToTwitter() {
        let user = UserManager.sharedInstance()
        if user == nil {
            UserManager.requestAccounts { (error, accounts) -> Void in
                if error != nil {
                    println(error)
                } else if let accountsUnwrap = accounts {
                    println(accountsUnwrap)
                    UserManager.loginWithAccount(accountsUnwrap[0], complete: { (error) -> Void in
                        self.pushStream()
                    })
                } else {
                    println("not granted")
                }
            }
        } else {
            pushStream()
        }
        
    }
    
    func pushProfile() {
        performSegueWithIdentifier("landingToProfile", sender: self)
    }
    
    func pushStream() {
        performSegueWithIdentifier("landingToStream", sender: self)
    }
    
}

