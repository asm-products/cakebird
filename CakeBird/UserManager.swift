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



class UserManager {
    
    
    struct Static {
        static var loggedIn: TwitterUser? = nil
        static var pred: dispatch_once_t = 0
    }
    
    class func requestAccounts(complete:(Array<ACAccount!>)->Void) {
        let store = ACAccountStore()
        let twitterType = ACAccountTypeIdentifierTwitter
        let type = store.accountTypeWithAccountTypeIdentifier(twitterType)
        let completion: ACAccountStoreRemoveCompletionHandler = {(granted: Bool, error: NSError!) -> Void in
            println("\(granted) \(error)")
            if granted {
                let accounts = store.accountsWithAccountType(type) as Array<ACAccount!>
                complete(accounts)
                
            } else {
                println("Not granted!")
            }
        }
        
        store.requestAccessToAccountsWithType(type, options: nil, completion: completion)
        
        
        
    }
    
    class func loginWithAccount(account: ACAccount, complete:()->Void) {
        println(account)
        Static.loggedIn = TwitterUser(account: account)
        saveUser()
        complete()
        
    }
    
    class func saveUser() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(Static.loggedIn)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(data, forKey: "userObject")
    }
    
    class func loginFallback() {
        
    }
    
    class func logout() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nil, forKey: "userObject")
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
}