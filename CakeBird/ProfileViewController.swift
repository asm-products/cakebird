//
//  ProfileViewController.swift
//  CakeBird
//
//  Created by Rhett Rogers on 8/23/14.
//  Copyright (c) 2014 Lyokotech. All rights reserved.
//

import Foundation
import UIKit


class ProfileViewController : SuperViewController {
   
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var bannerImage: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        if let user = UserManager.sharedInstance() {
            nameLabel.text = user.name
            handleLabel.text = user.handle
            tweetsLabel.text = "Tweets: \(user.tweets!)"
            followingLabel.text = "Following: \(user.following!)"
            followersLabel.text = "Followers: \(user.followers!)"
            profileImage.image = user.profileImage!
            bannerImage.image = user.bannerImage!
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}
