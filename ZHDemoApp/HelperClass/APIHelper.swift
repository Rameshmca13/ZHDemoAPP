//
//  APIHelper.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 24/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIHelper: NSObject {
//    class func requestGET(_ strMethod: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
//        let URL = twitterBaseURL + strMethod
//         Alamofire.request(URL).responseJSON { (responseObject) -> Void in
//            print(responseObject)
//            if responseObject.result.isSuccess {
//                let resJson = JSON(responseObject.result.value!)
//                success(resJson)
//            }
//            if responseObject.result.isFailure {
//                let error : Error = responseObject.result.error!
//                failure(error)
//            }
//        }
//    }
    
    class func requestGET(_ strMethod : String, headers : [String : String]?, success:@escaping (NSDictionary) -> Void, failure:@escaping (Error) -> Void){
        
        let URL = twitterBaseURL + strMethod
        
        Alamofire.request(URL, method:.post, parameters: nil, headers: headers).responseJSON { (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                //let resJson = JSON(responseObject.result.value!)
                let result = responseObject.result.value
                let JSON = result as! NSDictionary
                // print(resJson)
                print(JSON)
                success(JSON)
            }
            if responseObject.result.isFailure {
              //  print(responseObject.response?.statusCode)
                
                let error : Error = responseObject.result.error!
                failure(error)
                
            }
        }
    }
    
    func Header() -> HTTPHeaders {
        
      //  OAuth oauth_consumer_key="9KNfFrPf8JCznUvmq2pOaOJNv",oauth_token="2341579812-WgGC26wX4NymnfCmIHhhbxFrPdky5ieTYOgPlal",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1529848363",oauth_nonce="2ogTU2QZaCT",oauth_version="1.0",oauth_signature="jWXeQi03VDLPHh9MVnTS%2Bzhfyi0%3D"
        
//        print(UserDefaults.standard.value(forKey: TOKEN) ?? String())
//        print(UserDefaults.standard.value(forKey: TOKEN_SECRET) ?? String())
//
//        let token = UserDefaults.standard.value(forKey: TOKEN) ?? String()
//
//
//
//        let oAuth = "OAuth oauth_consumer_key=" + twitterConsumerKey + ",oauth_token=" + token + ",oauth_signature_method=HMAC-SHA1" + ",oauth_timestamp=" + "121231231" + ",oauth_nonce=nonce" + ",oauth_signature=" + ""
//
        
        
        let header : HTTPHeaders = ["Authorization":""]
        return header
    }
   
}
    

