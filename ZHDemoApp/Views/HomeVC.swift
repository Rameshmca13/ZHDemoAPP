//
//  HomeVC.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 24/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit
import Alamofire
import TwitterKit
import SDWebImage
import NVActivityIndicatorView


class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource,NVActivityIndicatorViewable {
    
    @IBOutlet weak var timelineTableview: UITableView!
    // var client: TwitterClient!
    var refreshControl: UIRefreshControl!
    
    var tweets: [Tweet]?
    var arrlistCount = 0

    let client = TWTRAPIClient()
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrlistCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVCell") as! HomeTVCell
        
        cell.lblName.text = tweets![indexPath.row].username as String?
       // cell.lblTime.text = tweets![indexPath.row].timestamp as Date
        cell.lblStatus.text = tweets![indexPath.row].text as String?
        cell.screenName.text = tweets![indexPath.row].screenname as String?
        
        let timestamp = tweets?[indexPath.row].timestamp
        if timestamp == nil {
            cell.lblTime.text =  ""
        } else {
            cell.lblTime.text =  "\(timestamp!)"
        }
        let ImgURL = tweets?[indexPath.row].profileUrl as String?
        if ImgURL != nil{
             cell.imgProfile.sd_setImage(with:URL(string:ImgURL! ), placeholderImage: UIImage(named: "PlaceHolderImage"), options: .refreshCached)
        }
         return cell
    }
    
    
    @objc func getTimeLine()  {
        TwitterClient.requestHomeTimeline(method: HOME, successs: { (response) in
            self.tweets = response
            self.arrlistCount = response.count
            self.timelineTableview.reloadData()
            self.refreshControl.endRefreshing()
        }) { (Error) in
           // self.ShowAlert(msg: "ERROR".localized(), Vc: self)
            self.stopAnimating()
        }
     }
    
    override func viewWillAppear(_ animated: Bool) {
        getTimeLine()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TWTRUser *user = [[TWTRUser alloc] initWithJSONDictionary:userDict];
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "refresh")
        refreshControl.addTarget(self, action:#selector(getTimeLine), for: .valueChanged)
        timelineTableview.addSubview(refreshControl) // not req
        
        
        self.startAnimating()
        TwitterClient.requestHomeTimeline(method: HOME, successs: { (response) in
            self.tweets = response
            self.arrlistCount = response.count
            self.timelineTableview.reloadData()
            self.stopAnimating()
        }) { (Error) in
            self.ShowAlert(msg: "ERROR".localized(), Vc: self)
            self.stopAnimating()
        }
        
        
        //Get user Details
        TwitterClient.requestUser(method: UserProfile, successs: { (user) in
            User.currentUser = user
        }) { (error) in
            
        }
      
        
//        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
//            let client = TWTRAPIClient(userID: userID)
//            // make requests with client
//
//            // let client = TWTRAPIClient()
//            let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/home_timeline.json"
//            var clientError : NSError?
//            let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: nil, error: &clientError)
//            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
//                if connectionError != nil {
//                    print("Error: \(connectionError)")
//                }
//
//                do {
//                    print(response)
//                    print(data)
//                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
//
//                    print("json: \(json)")
//                } catch let jsonError as NSError {
//                    print("json error: \(jsonError.localizedDescription)")
//                }
//            }
//
//
//        }
        
        
       
        
       

        
        
        
//        if client == nil {
//            client = TwitterClient()
//        }
////
//       client.Home()
        
        
//       let sting = "OAuth oauth_consumer_key=9KNfFrPf8JCznUvmq2pOaOJNv,oauth_token=2341579812-WgGC26wX4NymnfCmIHhhbxFrPdky5ieTYOgPlal,oauth_signature_method=HMAC-SHA1,oauth_timestamp=1529980243,oauth_nonce=2hEdokCl1OE,oauth_version=1.0,oauth_signature=%2BidxFzrhGCT511yG1GxlM1XEjfk%3D"
//
//
//
//    //    OAuth oauth_consumer_key="9KNfFrPf8JCznUvmq2pOaOJNv",oauth_token="2341579812-WgGC26wX4NymnfCmIHhhbxFrPdky5ieTYOgPlal",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1529848363",oauth_nonce="2ogTU2QZaCT",oauth_version="1.0",oauth_signature="jWXeQi03VDLPHh9MVnTS%2Bzhfyi0%3D"
//     //   let strVal = "OAuth oauth_consumer_key=" + "9KNfFrPf8JCznUvmq2pOaOJNv" + ",oauth_token=" + "2341579812-WgGC26wX4NymnfCmIHhhbxFrPdky5ieTYOgPlal" + ",oauth_signature_method=" + "HMAC-SHA1" + ",oauth_timestamp=" + "1529848363" + ",oauth_nonce=" + "2ogTU2QZaCT" + ",oauth_version=1.0" + ",oauth_signature=jWXeQi03VDLPHh9MVnTS%2Bzhfyi0%3D"
//
//     let header : HTTPHeaders = ["Authorization":sting]
//         APIHelper.requestGET(HOME, headers: header, success: { (response) in
//            print(response)
//        }) { (error) in
//            print(error)
//        }
       
         // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
