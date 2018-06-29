//
//  Status.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 28/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit

class Status: NSObject {
    var user: User
    var text: String
    var createdAt: NSDate
    var numberOfRetweets: Int
    var numberOfFavorites: Int

    init(dictionary: NSDictionary) {
        self.user = User(dictionary: dictionary["user"] as! NSDictionary)
        self.text = dictionary["text"] as! String

        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        self.createdAt = formatter.date(from: dictionary["created_at"] as! String)! as NSDate

        self.numberOfRetweets = dictionary["retweet_count"] as! Int
        self.numberOfFavorites = dictionary["favorite_count"] as! Int
    }

    class func statusesWithArray(array: NSDictionary) -> [Status] {
        var statuses = [Status]()
         statuses.append(Status(dictionary: array))
//        for dictionary in array {
//
//        }
        return statuses
    }
}
