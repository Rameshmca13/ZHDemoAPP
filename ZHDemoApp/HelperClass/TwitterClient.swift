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
                        let json3 = json as! Array<Any>
                        let coredata = CoreDataHandler()
                        coredata.insertTimelineContent(arraylist: json3)
                        
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
                        print(json1)
                        let Value = json1 .value(forKey: "statuses") as? NSArray
                        print(Value)
                        let Dict = Tweet.tweetsWithArray1(dictionaries:Value as! [NSDictionary])
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
    class func requestTrends(method: String, successs: @escaping ([Trends]) -> (), failure: @escaping (NSError) -> ()){
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            let client = TWTRAPIClient(userID: userID)
           // let userID = UserDefaults_Obj().value(forKey: userID)
            let params: NSDictionary = [
                "id": "1"
            ]
          //  UserDefaults_Obj().value(forKey: USER_ID) ?? String()
            
            let statusesShowEndpoint = twitterBaseURL + method
            var clientError : NSError?
            let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params as? [AnyHashable : Any], error: &clientError)
                client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                     print("Error: \(connectionError)")
                    failure(connectionError! as NSError)
                }
                do {
                    if data != nil{
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                       // let json1 = json as! NSDictionary
                        let json2 = json as! NSArray
                        let Dict = Trends.trendsWithArray(dictionaries: [json2])
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

