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
        super.viewDidLoad()

        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        performSegueWithIdentifier("loadLogin", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

