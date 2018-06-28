//
//  Constants.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 24/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit
import Foundation

let twitterConsumerKey = "9KNfFrPf8JCznUvmq2pOaOJNv"
let twitterConsumerSecret = "X4p19fO0B0Srh6GJuQBpCWMhoYEsCqC5ET4Su2RvYwti1bTC4I"
let twitterBaseURL = "https://api.twitter.com/"

let HOME = "1.1/statuses/home_timeline.json"
let UserProfile = "1.1/account/verify_credentials.json"
let TWEET_POST = "1.1/statuses/update.json"
let SEARCH = "1.1/search/tweets.json"
let TRENDING = "1.1/trends/place.json"


// UserDefault

let USER_ID = "userID"
let USER_NAME = "userNAME"
let TOKEN = "oauth_token"
let TOKEN_SECRET = "TokenSecret"


func UserDefaults_Obj() -> UserDefaults
{
    let userDefaults = UserDefaults.standard
    return userDefaults
    
}


