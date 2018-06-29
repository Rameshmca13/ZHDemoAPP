//
//  TrendDetailsVC.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 28/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit

class TrendDetailsVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var urlString =  String()
    override func viewDidLoad() {
        super.viewDidLoad()
//        var url = NSURL (string: urlString);
//        let request = NSURLRequest.init(url: url as! URL)
//        webView.loadRequest(request as URLRequest);
        print(urlString)
        let url = NSURL (string: urlString);
        let requestObj = NSURLRequest.init(url: url as! URL)
        webView.loadRequest(requestObj as URLRequest);

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
