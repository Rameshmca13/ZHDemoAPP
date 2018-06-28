//
//  ViewController.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 23/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin1(_ sender: Any) {
       Twitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                UserDefaults_Obj().set(session?.userID, forKey: USER_ID)
                UserDefaults_Obj().set(session?.userName, forKey: USER_NAME)
                UserDefaults_Obj().set(session?.authToken, forKey: TOKEN)
                UserDefaults_Obj().set(session?.authTokenSecret, forKey: TOKEN_SECRET)
                
                print(UserDefaults.standard.value(forKey: TOKEN) ?? String())
                print(UserDefaults.standard.value(forKey: TOKEN_SECRET) ?? String())
                self.performSegue(withIdentifier: "home", sender: self)
               
            } else {
                 self.ShowAlert(msg:"LOGINFAILED".localized(), Vc: self)
            }
        })
    }
    
  
    
}

