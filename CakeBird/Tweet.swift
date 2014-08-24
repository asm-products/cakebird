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
    var author: TwitterUser?
    var text: String?
    
    init(jsonTweet: [String: SwifteriOS.JSONValue]) {
        println(jsonTweet)
    }
}