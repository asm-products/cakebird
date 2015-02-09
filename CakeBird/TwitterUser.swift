//
//  TwitterUser.swift
//  CakeBird
//
//  Created by Rhett Rogers on 8/17/14.
//  Copyright (c) 2014 Lyokotech. All rights reserved.
//

import Foundation
import Twitter
import Accounts
import Social
import SwifteriOS

class TwitterUser : NSObject {
  
  var swifter:Swifter
  var account:ACAccount
  
  var userObject:[String:SwifteriOS.JSONValue]?
  var location: String?
  var favorites: Int?
  var bio: String?
//  var profileImage: UIImage?
//  var bannerImage: UIImage?
  var name: String?
  var handle: String?
  var timeZone: String?
  var accountCreatedDate: NSDate?
  var tweets: Int?
  var following: Int?
  var followers: Int?
  var language: String?
  
  
  init(swifter: Swifter, account: ACAccount, callback:()->Void) {
    self.swifter = swifter
    self.account = account
    super.init()
    fillUserInfo(callback)
  }
  
  func fillUserInfo(callback:()->Void) {
    swifter.getUsersShowWithScreenName(account.username, includeEntities: true, success: { (user) -> Void in
      if let unwrappedUser = user {
        self.userObject = user
        self.location = unwrappedUser["location"]!.string
        self.favorites = unwrappedUser["favourites_count"]!.integer
        self.bio = unwrappedUser["description"]!.string
        //                self.profileImage = UIImage(data: NSData(contentsOfURL: NSURL(string: unwrappedUser["profile_image_url_https"]!.string!)))
        //                self.bannerImage = UIImage(data: NSData(contentsOfURL: NSURL(string: unwrappedUser["profile_banner_url"]!.string!)))
        self.name = unwrappedUser["name"]!.string
        self.handle = unwrappedUser["screen_name"]!.string
        self.timeZone = unwrappedUser["time_zone"]!.string
        self.tweets = unwrappedUser["statuses_count"]!.integer
        self.following = unwrappedUser["friends_count"]!.integer
        self.followers = unwrappedUser["followers_count"]!.integer
        self.language = unwrappedUser["lang"]!.string
        callback()
      } else {
        println("EXTREME ERROR")
      }
      }) { (error) -> Void in
        println("ERROR: \(error)")
    }
  }
  
  func getUserStream(callback:(error: NSError!, jsonTweets: [JSONValue]?)->Void) {
    swifter.getStatusesHomeTimelineWithCount(20, sinceID: nil, maxID: nil, trimUser: true, contributorDetails: true, includeEntities: true, success: { (statuses: [JSONValue]?) -> Void in
      callback(error: nil, jsonTweets:statuses)
      }) { (error) -> Void in
        callback(error: error, jsonTweets: nil)
    }
  }
  
  
  func description() -> String {
    if let h = handle {
      if let n = name {
        return "@\(h) – \(n)"
      }
    }
    return "Incomplete User"
  }
  
  func encodeWithCoder(coder: NSCoder) {
    coder.encodeObject(account, forKey: "account")
    coder.encodeObject(location!, forKey: "location")
    coder.encodeObject(favorites!, forKey: "favorites")
    coder.encodeObject(bio!, forKey: "bio")
//    coder.encodeObject(profileImage!, forKey: "profileImage")
//    coder.encodeObject(bannerImage!, forKey: "bannerImage")
    coder.encodeObject(name!, forKey: "name")
    coder.encodeObject(handle!, forKey: "handle")
    coder.encodeObject(timeZone!, forKey: "timeZone")
    coder.encodeObject(tweets!, forKey: "tweets")
    coder.encodeObject(following!, forKey: "following")
    coder.encodeObject(followers!, forKey: "followers")
    coder.encodeObject(language!, forKey: "language")
  }
  
  init(coder: NSCoder) {
    self.account = coder.decodeObjectForKey("account") as ACAccount
    self.swifter = Swifter(account: self.account)
    self.location = coder.decodeObjectForKey("location") as? String
    self.favorites = coder.decodeObjectForKey("favorites") as? Int
    self.bio = coder.decodeObjectForKey("bio") as? String
//    self.profileImage = coder.decodeObjectForKey("profileImage") as? UIImage
//    self.bannerImage = coder.decodeObjectForKey("bannerImage") as? UIImage
    self.name = coder.decodeObjectForKey("name") as? String
    self.handle = coder.decodeObjectForKey("handle") as? String
    self.timeZone = coder.decodeObjectForKey("timeZone") as? String
    self.tweets = coder.decodeObjectForKey("tweets") as? Int
    self.following = coder.decodeObjectForKey("following") as? Int
    self.followers = coder.decodeObjectForKey("followers") as? Int
    self.language = coder.decodeObjectForKey("language") as? String
  }
  
}