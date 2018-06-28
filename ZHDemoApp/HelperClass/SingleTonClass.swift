//
//  SingleTonClass.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 24/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit
import Reachability

class SingleTonClass: NSObject {
}

extension UIViewController{
    func CheckNetwork()
    {
        let reachability = Reachability()!
        if reachability.isReachable
        {
            // print("Network reachable")
        }
        else
        {
            self.ShowAlert(msg: "CHECKNET".localized(), Vc: self)
            return
            
        }
     }
    func ShowAlert(msg:String , Vc:UIViewController)  {
        let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            
            (result : UIAlertAction) -> Void in
        }
        alert.addAction(okAction)
        Vc.present(alert, animated: true, completion: nil)
        
    }
}

extension String {
     func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}


