//
//  UserManager.swift
//  CakeBird
//
//  Created by Rhett Rogers on 8/16/14.
//  Copyright (c) 2014 Lyokotech. All rights reserved.
//

import Foundation
import Accounts
import Twitter
import SwifteriOS


class UserManager {
  
  
  struct Static {
    static var loggedIn: TwitterUser? = nil
    static var pred: dispatch_once_t = 0
    static var swifter: Swifter? = nil
  }
  
  class func requestAccounts(complete:(NSError?, [ACAccount]?)->Void) {
    let store = ACAccountStore()
    let type = store.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    store.requestAccessToAccountsWithType(type, options: nil) { (granted, error) -> Void in
      if error != nil {
        complete(error, nil)
      } else if granted {
        let accounts = store.accountsWithAccountType(type) as [ACAccount]
        complete(nil, accounts)
      } else {
        complete(nil, nil)
      }
      
      
    }
    
    
  }
  
  class func loginWithAccount(account: ACAccount, complete:(NSError?)->Void) {
    Static.swifter = Swifter(account: account)
    Static.loggedIn = TwitterUser(swifter: Static.swifter!, account: account) { () in
      complete(nil)
      self.saveUser()
    }
    
  }
  
  class func loginFallback() {
    let path = NSBundle.mainBundle().pathForResource("TwitterSettings", ofType: "plist")!
    var consumer = NSDictionary(contentsOfFile: path)
    Static.swifter = Swifter(consumerKey: consumer?.objectForKey("CONSUMER_KEY") as String, consumerSecret: consumer?.objectForKey("CONSUMER_SECRET") as String)
  }
  
  class func logout() {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.removeObjectForKey("userObject")
    Static.loggedIn = nil
  }
  
  
  class func sharedInstance() -> TwitterUser? {
    if let user = Static.loggedIn {
      return user
    } else {
      dispatch_once(&Static.pred) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let data: NSData? = defaults.objectForKey("userObject") as? NSData
        if let liveData = data {
          Static.loggedIn = NSKeyedUnarchiver.unarchiveObjectWithData(liveData) as? TwitterUser
          Static.swifter = Swifter(account: Static.loggedIn!.account)
        } else {
          Static.loggedIn = nil
        }
      }
      if let user = Static.loggedIn {
        return user
      } else {
        return nil
      }
      
      
    }
  }
  
  
  class func saveUser() {
    let data = NSKeyedArchiver.archivedDataWithRootObject(Static.loggedIn!)
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(data, forKey: "userObject")
  }
}