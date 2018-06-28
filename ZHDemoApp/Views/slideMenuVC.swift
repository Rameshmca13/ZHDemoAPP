//
//  slideMenuVC.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 27/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import TwitterKit

class slideMenuVC: UIViewController,UITableViewDelegate, UITableViewDataSource, NVActivityIndicatorViewable {
    let segues = ["Search", "Home", "Profile", "Trending", "Logout"]
    private var previousIndex: NSIndexPath?
    var arrMenuItems: [String] = ["Search", "Home", "Profile", "Trending", "Logout"]
    
  

    @IBOutlet weak var menuTableview: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = User.currentUser?.name as String?
        imgProfile.sd_setImage(with:URL(string:(User.currentUser?.profileUrl as String?)! ), placeholderImage: UIImage(named: "PlaceHolderImage"), options: .refreshCached)
       
      
        // Do any additional setup after loading the view.
    }

//    override func viewWillAppear(_ animated: Bool)
//    {
//         self.navigationController?.navigationBar.isHidden = true
//        NotificationCenter.default.addObserver(self, selector: #selector(slideMenuVC.methodOfReceivedNotification(notification:)), name: Notification.Name("SETIMAGEANDNAME"), object: nil)
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuItems.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = self.arrMenuItems[indexPath.row]
        let cell:UITableViewCell = self.menuTableview.dequeueReusableCell(withIdentifier: identifier)!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)  {
        
        let identifier = self.arrMenuItems[indexPath.row]
        let cell:UITableViewCell = self.menuTableview.dequeueReusableCell(withIdentifier: identifier)!
        
        //        if #available(iOS 11.0, *) {
        //            cell.textLabel?.textColor = UIColor.init(named: "redColor")
        //        } else {
        //             cell.textLabel?.textColor = UIColor.red // UIColor(red: 56/255, green: 84/255, blue: 136/255, alpha: 1)
        //            // Fallback on earlier versions
        //        }
        
        if indexPath.row == 4
        {
            let UserID = UserDefaults.standard.value(forKey: USER_ID) ?? String()
            Twitter.sharedInstance().sessionStore .logOutUserID(UserID as! String)
           
            let story = UIStoryboard.init(name: "Main", bundle: nil)
            let HomeVC = story.instantiateViewController(withIdentifier: "ViewController")as! ViewController
            self.navigationController?.present(HomeVC, animated: true, completion: nil)
          //  self.navigationController?.pushViewController(HomeVC, animated: false)
            UserDefaults_Obj().removeObject(forKey: USER_ID)
            UserDefaults_Obj().removeObject(forKey: USER_NAME)
            UserDefaults_Obj().removeObject(forKey: TOKEN)
            UserDefaults_Obj().removeObject(forKey: TOKEN_SECRET)
        }
        else
        {
            self.performSegue(withIdentifier: segues[indexPath.row], sender: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
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
