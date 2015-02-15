//
//  Tweet.swift
//  CakeBird
//
//  Created by Rhett Rogers on 8/23/14.
//  Copyright (c) 2014 Lyokotech. All rights reserved.
//

import Foundation
import SwifteriOS
import UIKit

class Tweet {
  var author: String?
  var authorAvatar: UIImage?
  var authorName: String?
  var text: String?
  var urls: [String]?

  var retweetCount: String
//  var replyCount: String
  var favoriteCount: String
  
  init(jsonTweet: JSON) {
    text = Tweet.parseText(jsonTweet["text"].string!)
    retweetCount = String(jsonTweet["retweet_count"].integer!)
    favoriteCount = String(jsonTweet["favorite_count"].integer!)
    var userId = jsonTweet["user"].object!["id_str"]!.string!
    UserManager.Static.swifter?.getUsersLookupWithUserIDs([userId], includeEntities: true, success: { (users) -> Void in
      let user = users![0]
      self.author = "@".stringByAppendingString(user["screen_name"].string!)
//      self.authorAvatar =
//        user["profile_image_url"].string!
      self.authorName = user["name"].string!
    }, failure: { (error) -> Void in
      println(error)
    })
    println(userId)
  }
  
  class func parseText(text: String) -> String {
    var returnText = text.stringByReplacingOccurrencesOfString("&lt;", withString: "<", options: nil, range: nil)
    return returnText
  }
  
  
}