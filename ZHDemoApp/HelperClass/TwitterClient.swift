//
//  TwitterClient.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 23/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit
import TwitterKit
import SwiftyJSON

class TwitterClient : NSObject {
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    class func requestHomeTimeline(method: String, successs: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()){
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            let client = TWTRAPIClient(userID: userID)
            let statusesShowEndpoint = twitterBaseURL + method
             var clientError : NSError?
             let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: nil, error: &clientError)
             client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                    failure(connectionError! as NSError)
                }
                 do {
                    if data != nil{
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            let json1 = json as! NSArray
                            let Dict = Tweet.tweetsWithArray(dictionaries: [json1])
                         successs(Dict)
                    }else{
                        failure(connectionError! as NSError)
                    }
                    
                 } catch let jsonError as NSError {
                     failure(jsonError)
                    print("json error: \(jsonError.localizedDescription)")
                    
                }
            }
        }
    }
    
    class func requestUser(method: String, successs: @escaping (User) -> (), failure: @escaping (NSError) -> ()){
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            let client = TWTRAPIClient(userID: userID)
            let statusesShowEndpoint = twitterBaseURL + method
            var clientError : NSError?
            let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: nil, error: &clientError)
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                    failure(connectionError! as NSError)
                }
                do {
                    if data != nil{
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        let userDictionary = json as! NSDictionary
                        print(userDictionary)
                        let user = User(dictionary: userDictionary)
                        successs(user)
                       
                    }else{
                        failure(connectionError! as NSError)
                    }
                    
                } catch let jsonError as NSError {
                    failure(jsonError)
                    print("json error: \(jsonError.localizedDescription)")
                    
                }
            }
        }
    }
    
    class func requestPostTweet(method: String,params :NSDictionary, successs: @escaping ([Status]) -> (), failure: @escaping (NSError) -> ()){
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            let client = TWTRAPIClient(userID: userID)
            let statusesShowEndpoint = twitterBaseURL + method
            var clientError : NSError?
            let request = client.urlRequest(withMethod: "POST", url: statusesShowEndpoint, parameters: params as? [AnyHashable : Any], error: &clientError)
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                    failure(connectionError! as NSError)
                }
                do {
                    if data != nil{
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        let userDictionary = json as! NSDictionary
                        print(userDictionary)
                        
                        let statuses = Status.statusesWithArray(array:userDictionary )
                       
                        successs(statuses)
                        
                    }else{
                        failure(connectionError! as NSError)
                    }
                    
                } catch let jsonError as NSError {
                    failure(jsonError)
                    print("json error: \(jsonError.localizedDescription)")
                    
                }
            }
        }
    }
    
    class func requestSearch(method: String,params :NSDictionary, successs: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()){
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            let client = TWTRAPIClient(userID: userID)
            let statusesShowEndpoint = twitterBaseURL + method
            var clientError : NSError?
            let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params as! [AnyHashable : Any], error: &clientError)
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                    failure(connectionError! as NSError)
                }
                do {
                    if data != nil{
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        let json1 = json as! NSDictionary
                        let Value = json1 .value(forKey: "statuses")
                        let Dict = Tweet.tweetsWithArray(dictionaries:Value as! [NSArray])
                        successs(Dict)
                    }else{
                        failure(connectionError! as NSError)
                    }
                    
                } catch let jsonError as NSError {
                    failure(jsonError)
                    print("json error: \(jsonError.localizedDescription)")
                    
                }
            }
        }
    }
    
    
    
}



//if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
//    let client = TWTRAPIClient(userID: userID)
//
//    let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/home_timeline.json"
//    let params = ["id": "20"]
//    var clientError : NSError?
//
//    let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: nil, error: &clientError)
//
//    client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
//        if connectionError != nil {
//            print("Error: \(connectionError)")
//        }
//
//        do {
//            print(response)
//            print(data)
//            let json = try JSONSerialization.jsonObject(with: data!, options: [])
//            print("json: \(json)")
//        } catch let jsonError as NSError {
//            print("json error: \(jsonError.localizedDescription)")
//        }
//    }
//
//
//}


