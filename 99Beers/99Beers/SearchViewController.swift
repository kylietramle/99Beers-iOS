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
    
//    var beers = [Beer]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        makeAPICall()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCellWithIdentifier("BeerResultCell", forIndexPath: indexPath)
        
        return cell
        
    }
    
    func makeAPICall() {
        Alamofire.request(.GET, "https://api.untappd.com/v4/beer/info/16630?client_id=\(clientID)&client_secret=\(clientKey)").responseJSON { response in
            if let json = response.result.value {
                print (json["meta"]!!["code"])
                print (json["response"])
            }
        }
    }
    
}


