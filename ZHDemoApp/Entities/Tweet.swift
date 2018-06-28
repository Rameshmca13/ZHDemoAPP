//
//  Tweet.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 25/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit

class Tweet: NSObject {
  
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var username: NSString?
    var profileUrl: NSString?
    var screenname: NSString?
    var tweetID: NSString?
    var favorited: Bool?
    var retweeted: Bool?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String as NSString?
        retweetCount = (dictionary["retweet_count"] as? Int ) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
//        username = dictionary["name"] as? String as NSString?
//        screenname = dictionary["screen_name"] as? String as NSString?
        
        favorited = dictionary["favorited"] as? Bool
        retweeted = dictionary["retweeted"] as? Bool
        
        
        let dictuser = dictionary["user"] as? NSDictionary
        username = dictuser!["name"] as? String as NSString?
        screenname = dictuser!["screen_name"] as? String as NSString?
        tweetID = dictuser!["id_str"] as? String as NSString?
        
        
        let profileUrlString = dictuser!["profile_image_url"] as? String as NSString?
        if let profileUrlString = profileUrlString {
            profileUrl =  profileUrlString //NSURL(string: profileUrlString as String)
        }
        
        
        let timestampString = dictionary["created_at"] as? String as NSString?
        if let timestampString = timestampString {
            let formatter = DateFormatter()
          //  formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
              formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString as String) as NSDate?
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSArray]) -> [Tweet] {
        print(dictionaries)
        var tweets = [Tweet]()
        var TweetsCount = 0
        for dictValue in dictionaries{
            for dictLocal in dictValue{
               TweetsCount = TweetsCount + 1
                let tweet = Tweet(dictionary: dictLocal as! NSDictionary)
                            tweets.append(tweet)

            }
            
        }
        print(TweetsCount)
        
//        for dictionary in dictionaries {
//            let tweet = Tweet(dictionary: dictionary)
//            tweets.append(tweet)
//        }
        return tweets
    }
    
}
