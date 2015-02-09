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
  
  init(jsonTweet: JSON) {
    println(jsonTweet)
    text = jsonTweet["text"].string!
//    author = jsonTweet["user"]["id_str"]
  }
}