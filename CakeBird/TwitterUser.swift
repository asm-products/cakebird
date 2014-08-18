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

class TwitterUser : NSObject {
    var username:   String?
    var accountId:  String?
    var account: ACAccount
    
    
    init(account: ACAccount) {
        self.account = account
        super.init()

        username = "SerenadeXS"
        requestUserInfo()
    }
    
    func requestUserInfo() {
        let url = "https://api.twitter.com/1.1/users/show.json"
        
        let params: Dictionary<NSObject, AnyObject> = Dictionary<NSObject, AnyObject>(minimumCapacity: 1)
        makeSLRequest(url, params: params, body: nil) { (error, data) -> Void in
           println("\(error) \(data)")
        }
    }
    
    func encodeWithCoder(coder:NSCoder) {
        coder.encodeObject(username, forKey: "username")
        coder.encodeObject(accountId, forKey: "accountId")
        coder.encodeObject(account, forKey: "account")
    }
    
    init(coder:NSCoder) {
        account = coder.decodeObjectForKey("account") as ACAccount
        super.init()
        username = coder.decodeObjectForKey("username") as? String
        accountId = coder.decodeObjectForKey("accountId") as? String

    }
    
    
    func description() -> String {
        if let returnString = username {
            return returnString
        } else {
            return "NOT SETUP YET! \(super.description)"
        }
    }
    
    func makeSLRequest(url: String, params: Dictionary<NSObject, AnyObject>, body: Dictionary<String, AnyObject>?, callback:(error: NSError?, data: Dictionary<String, AnyObject>?)->Void) {
        let urlObj = NSURL(string: url)
        println(urlObj)
        println(url)
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: urlObj, parameters: params);
        request.account = account
        request.performRequestWithHandler {(data: NSData!, response: NSHTTPURLResponse!, error: NSError!) -> Void in
            if error != nil {
                callback(error: error, data: nil)
                return
            } else {
                var jsonError: NSError? = nil
                var responseDict = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as Dictionary<String, AnyObject>
                if let error = jsonError {
                    callback(error:error, data: nil)
                    return
                }
                callback(error:nil, data: responseDict)
            }
            
        }
    }
}