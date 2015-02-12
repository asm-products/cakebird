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
  var tweets: [Tweet] = [Tweet]()
  
  
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    if let user = UserManager.sharedInstance(){
      user.getUserStream({ (error, jsonTweets) -> Void in
        if error != nil {
          println(error)
        }
        if let jTweets = jsonTweets {
          for jsonTweet in jTweets {
            
            self.tweets.append(Tweet(jsonTweet: jsonTweet))
            
          }
        }
        self.tweetStream.reloadData()
      })
    }
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

  }
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return tweets.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    var cell = collectionView.dequeueReusableCellWithReuseIdentifier("tweet", forIndexPath: indexPath) as TweetCell
    var tweet = tweets[indexPath.item]
    cell.text.text = tweet.text
    cell.favoriteCountLabel.text = tweet.favoriteCount
    cell.retweetCountLabel.text = tweet.retweetCount
    return cell
  }
  
  
}