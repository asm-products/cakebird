//
//  LoginLandingViewController.swift
//  CakeBird
//
//  Created by Rhett Rogers on 2/8/15.
//  Copyright (c) 2015 Lyokotech. All rights reserved.
//

import UIKit
import Accounts
import SwifteriOS

class LoginLandingViewController: SuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func useWebCredentials(sender: AnyObject) {
        loginToTwitterWeb()
    }


    @IBAction func useIOSCredentials(sender: AnyObject) {
        loginToTwitterIOS()
    }
    
    
    func loginToTwitterIOS() {
        let user = UserManager.sharedInstance()
        if user == nil {
            UserManager.requestAccounts { (error, accounts) -> Void in
                if error != nil {
                    println(error)
                } else if let accountsUnwrap = accounts {
                    println(accountsUnwrap)
                    if accountsUnwrap.count < 1 {
                        self.loginToTwitterWeb()
                    }
                    if accountsUnwrap.count > 1 {
                        //Need to popover an account selector
                    }
                    if accountsUnwrap.count == 1 {
                        UserManager.loginWithAccount(accountsUnwrap[0], complete: { (error) -> Void in
                            self.pushStream()
                        })
                    }
                } else {
                    println("not granted")
                }
            }
        } else {
            pushStream()
        }
        
    }
    
    func loginToTwitterWeb() {
        println("No twitter login.. Web login required")
    }
    
    
    func pushStream() {
        performSegueWithIdentifier("landingToStream", sender: self)
    }
}
