//
//  TrendsVC.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 28/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class TrendsVC: UIViewController,UITableViewDataSource,UITableViewDelegate,NVActivityIndicatorViewable {
    @IBOutlet weak var trendsTableview: UITableView!
    var trends: [Trends]?
    var arrlistCount = 0
    var URLstring = String()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.startAnimating()
        TwitterClient.requestTrends(method: TRENDING, successs: { (response) in
            self.stopAnimating()
            self.arrlistCount = response.count
            self.trends = response
            self.trendsTableview.reloadData()
            
        }) { (error) in
            self.ShowAlert(msg: "ERROR".localized(), Vc: self)
            self.stopAnimating()
        }
        
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrlistCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendsTVCell") as! TrendsTVCell
        cell.textLabel?.text = trends![indexPath.row].name as String?
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        URLstring = (trends![indexPath.row].url as String?)!
        self.performSegue(withIdentifier: "details", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    //  MARK: - Navigation

 //    In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
        
        if segue .identifier == "details"
        {
            let details = segue.destination as? TrendDetailsVC
            details?.urlString = URLstring
            
            
        }
    }
    

}
