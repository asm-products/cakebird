//
//  Tweet.swift
//  CakeBird
//
//  Created by Rhett Rogers on 8/23/14.
//  Copyright (c) 2014 Lyokotech. All rights reserved.
//

import Foundation
import SwifteriOS

class Tweet {
  var author: String?
  var text: String?
  var urls: [String]?
  var retweetCount: String
//  var replyCount: String
  var favoriteCount: String
  
  init(jsonTweet: JSON) {
    text = Tweet.parseText(jsonTweet["text"].string!)
    retweetCount = String(jsonTweet["retweet_count"].integer!)
    favoriteCount = String(jsonTweet["favorite_count"].integer!)
    println(jsonTweet)
  }
  
  class func parseText(text: String) -> String {
    var returnText = text.stringByReplacingOccurrencesOfString("&lt;", withString: "<", options: nil, range: nil)
    return returnText
  }
  
  
}