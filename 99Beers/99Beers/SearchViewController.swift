//
//  SearchViewController.swift
//  99Beers
//
//  Created by Kylie Tram Le on 10/8/16.
//  Copyright © 2016 Kylie Tram Le. All rights reserved.
//

import UIKit
import Alamofire

let clientID = "32BEBC190F5DE4785EED12F6527239AF2623E77D"
let clientKey = "76BFCCB912EAB5AB2FFC7672C55A5E9530F9492F"

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchResultTableView: UITableView!
    
    var beers: [Beer]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        print("here?")
        makeAPICall()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return beers!.count ?? 0
        

    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCellWithIdentifier("BeerResultCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = beers![indexPath.row] as? String
        return cell
        
    }
    
    func makeAPICall() {
         Alamofire.request(.GET, "https://api.untappd.com/v4/search/beer?q=asahi&client_id=32BEBC190F5DE4785EED12F6527239AF2623E77D&client_secret=76BFCCB912EAB5AB2FFC7672C55A5E9530F9492F").responseJSON { response in
                if let json = response.result.value {
                    print ("Connection to API successful!")
                    if let secondJSON = json["response"] as! NSDictionary? {
                        if let beersJSON = secondJSON["beers"] as! NSDictionary? {
                            if let beerItems = beersJSON["items"] as! [NSDictionary]? {
                                var beersJsonArray: [AnyObject] = []
                                for beerObject in beerItems {
                                    let insideBeerHash = beerObject["beer"]
                                    beersJsonArray.append(insideBeerHash!)
                                    
                                    print (beersJsonArray)
                                    
                                }
                            }
                        }
                    }
            }
            
        }
    }
}
