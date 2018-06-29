//
//  ProfileVC.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 28/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var lblFollower: UILabel!
    @IBOutlet weak var lblFollwing: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblScreenName: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = User.currentUser?.name as String?
        lblScreenName.text = User.currentUser?.screenname as String?
        imgProfile.sd_setImage(with:URL(string: (User.currentUser?.profileUrl as String?)! ), placeholderImage: UIImage(named: "PlaceHolderImage"), options: .refreshCached)
        let dictValue = User.currentUser?.dictionary
        
        lblLocation.text = dictValue?["location"] as? String
        let following : Int = (dictValue?["friends_count"] as? Int)!
       // self.streamerUserID = String(following)
        lblFollwing.text = String(following)  + "  Following"
         let follower : Int = (dictValue?["followers_count"] as? Int)!
        lblFollower.text = String(follower)  + "  Follower"
        
        print(User.currentUser?.dictionary)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
