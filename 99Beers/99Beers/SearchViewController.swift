//
//  SearchViewController.swift
//  99Beers
//
//  Created by Kylie Tram Le on 10/8/16.
//  Copyright © 2016 Kylie Tram Le. All rights reserved.
//

import UIKit
import Alamofire


let clientID = valueForAPIKey(keyname: "CLIENT_ID")
let clientKey = valueForAPIKey(keyname: "CLIENT_KEY")

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchResultTableView: UITableView!
    
    var beers = [Beer]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        makeAPICall()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    }
    
    func makeAPICall() {
        Alamofire.request(.GET, "https://api.untappd.com/v4/method_name?client_id=\(clientID)&client_secret=\(clientKey)").responseJSON { response in
            if let json = response.result.value {
                if let status_code = json["status_code"] as? Int {
                    print("ERROR: Unable to hit the API with status code: \(status_code)")
                    print("Got status message: \(json["status_message"] as! String)")
                }
                else {
                    print("Connection to API successful!")
                    self.movies = Movie.movies((json["results"] as? [NSDictionary])!)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
