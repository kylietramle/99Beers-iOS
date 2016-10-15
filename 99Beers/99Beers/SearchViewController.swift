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
    
    var beers: [Beer]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        makeAPICall()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return beers!.count ?? 0

    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCellWithIdentifier("BeerResultCell", forIndexPath: indexPath)
        
//        cell.textLabel?.text = beers![indexPath.row] as! String
        return cell
        
    }
    
    func makeAPICall() {
        Alamofire.request(.GET, "https://api.untappd.com/v4/search/beer?q=Pliny&client_id=\(clientID)&client_secret=\(clientKey)").responseJSON { response in
            if let json = response.result.value {
                print ("Connection to API successful!")
                if (json["response"]!!["beers"]!!["items"]!!["beer"]) != nil {
                    let newBeerItem = Beer.(json["response"]!!["beers"]!!["items"]!!["beer"] as? [NSDictionary]!)
                    print (newBeerItem)
                    self.beers.append(newBeerItem)
                    self.searchResultTableView.reloadData()
                }
            }
        }
    }
    
}


