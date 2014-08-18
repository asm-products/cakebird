//
//  LandingViewController.swift
//  CakeBird
//
//  Created by Rhett Rogers on 8/16/14.
//  Copyright (c) 2014 Lyokotech. All rights reserved.
//

import UIKit
import Accounts


class LandingViewController: SuperViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = UserManager.sharedInstance() {
            println(user)
            UserManager.logout()
        } else {
            self.loginToTwitter()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginToTwitter() {

        UserManager.requestAccounts() { (accounts:Array<ACAccount!>) in
            println(accounts)
            UserManager.loginWithAccount(accounts[0]) {
                println("done")
                if let user = UserManager.sharedInstance() {
                    println(user)
                }
            }
        }
    }
    

}

