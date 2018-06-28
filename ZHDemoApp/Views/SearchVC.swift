//
//  SearchVC.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 28/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit

class SearchVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    var tweets: [Tweet]?
    var arrlistCount = 0

    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var serchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0{
            return
         }
        
        let params: NSDictionary = [
            "q": searchText
        ]
        TwitterClient.requestSearch(method: SEARCH, params: params, successs: { (response) in
            self.tweets = response
            self.arrlistCount = response.count
            self.serchTableView.reloadData()
        }) { (error) in
        }
        
    }
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
