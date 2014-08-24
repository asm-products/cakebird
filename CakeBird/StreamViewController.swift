//
//  StreamViewController.swift
//  CakeBird
//
//  Created by Rhett Rogers on 8/23/14.
//  Copyright (c) 2014 Lyokotech. All rights reserved.
//

import Foundation
import UIKit
import SwifteriOS

class StreamViewController: SuperViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var tweetStream: UICollectionView!
    var tweets: [Tweet]?
    
    override func viewWillAppear(animated: Bool) {
        if let user = UserManager.sharedInstance(){
            user.getUserStream({ (error, jsonTweets) -> Void in
                println(error)
                println(jsonTweets)
            })
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("tweet", forIndexPath: indexPath) as TweetCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        if let t = tweets {
            return t.count
        }
        return 0
    }
    
    
}