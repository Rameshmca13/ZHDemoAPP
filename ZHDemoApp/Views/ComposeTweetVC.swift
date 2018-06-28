
//
//  ComposeTweetVC.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 28/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class ComposeTweetVC: UIViewController,NVActivityIndicatorViewable {
    let MAX_CHARACTERS_ALLOWED = 140
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var remainingCharactersLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImage.sd_setImage(with:URL(string:User.currentUser?.profileUrl as! String ), placeholderImage: UIImage(named: "PlaceHolderImage"), options: .refreshCached)
        self.profileImage.layer.cornerRadius = 9.0
        self.profileImage.layer.masksToBounds = true
        self.nameLabel.text = User.currentUser?.name as! String
        self.screennameLabel.text = User.currentUser?.screenname as! String
        
//        NotificationCenter.defaultCenter.addObserverForName(UIKeyboardDidShowNotification, object: nil, queue: nil) { (notification: NSNotification!) -> Void in
//            let userInfo = notification.userInfo!
//            let keyboardFrameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
//            self.view.frame = CGRectMake(0, 0, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y)
//        }
        
//        NotificationCenter.defaultCenter.addObserverForName(UIKeyboardDidHideNotification, object: nil, queue: nil) { (notification: NSNotification!) -> Void in
//            let userInfo = notification.userInfo!
//            let keyboardFrameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
//            self.view.frame = CGRectMake(0, 0, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y)
//        }
        
        //self.remainingCharactersLabel.text = "\(MAX_CHARACTERS_ALLOWED)"
        
        self.textView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
      //  self.adjustScrollViewContentSize()
    }
    
    func textViewDidChange(textView: UITextView) {
        let status = textView.text
     //   let charactersRemaining = MAX_CHARACTERS_ALLOWED - (status?.count)!
      //  self.remainingCharactersLabel.text = "\(charactersRemaining)"
      //  self.remainingCharactersLabel.textColor = charactersRemaining >= 0 ? .lightGrayColor() : .redColor()
       // self.adjustScrollViewContentSize()
    }
    
//    func adjustScrollViewContentSize() {
//        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: textView.frame.origin.y + 250)
//
//    }
    @IBAction func onCancelTap(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostTweet(sender: AnyObject) {
        
        if textView.text.count == 0{
            return
        }
        let params: NSDictionary = [
            "status": textView.text
        ]
        
        textView .resignFirstResponder()
        self.startAnimating()
        TwitterClient.requestPostTweet(method: TWEET_POST, params: params, successs: { (resposne) in
           self.stopAnimating()
            self.dismiss(animated: true, completion: nil)
            
        }) { (error) in
            self.ShowAlert(msg: "ERROR".localized(), Vc: self)
            self.stopAnimating()
            
        }
        
        
//        self.startAnimating()
//        TwitterClient.requestHomeTimeline(method: HOME, successs: { (response) in
//            self.tweets = response
//            self.arrlistCount = response.count
//            self.timelineTableview.reloadData()
//            self.stopAnimating()
//        }) { (Error) in
//            print(Error)
//        }
        
    }
    
    
    @IBAction func onScrollViewTap(sender: AnyObject) {
       // self.textView.becomeFirstResponder()
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
