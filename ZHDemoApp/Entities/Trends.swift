//
//  Trends.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 28/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit

class Trends: NSObject {
    
    var name: NSString?
    var url: NSString?
    //var profileUrl: NSURL?
    var quary: NSString?
    var tweetValue: Int = 0
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        print(dictionary)
        name = dictionary["name"] as? String as NSString?
        url = dictionary["url"] as? String as NSString?
        quary = dictionary["query"] as? String as NSString?
        tweetValue = (dictionary["tweet_volume"] as? Int ) ?? 0
     }
    
    class func trendsWithArray(dictionaries: [NSArray]) -> [Trends] {
        print(dictionaries)
        var tweets = [Trends]()
         for dictValue in dictionaries{
            print(dictValue)
             for dictLocal in dictValue{
                let localArray = (dictLocal as AnyObject) .value(forKey: "trends") as? NSArray
                   for dictTrends in localArray!{
                    let tweet = Trends(dictionary: dictTrends as! NSDictionary)
                    tweets.append(tweet)
                }
              }
        }
        return tweets
    }
    

}
