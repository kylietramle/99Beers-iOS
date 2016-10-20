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

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    @IBOutlet weak var searchResultTableView: UITableView!
    
    var beers: [Beer]? = []
    var filteredBeers = [Beer]()
    
    var searchController: UISearchController!
    var resultsController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        makeAPICall()
        
        // look for search results in itself
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        
        // build search bar
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        self.searchResultTableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // filter through the beers
            
        self.filteredBeers = (self.beers?.filter({ (beer: Beer) -> Bool in
            if beer.beerName!.containsString(self.searchController.searchBar.text!) {
                return true
            } else {
                return false
            }
        }))!
        // update the results TableView
        self.resultsController.tableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchResultTableView {
            return beers?.count ?? 0
        } else {
            return filteredBeers.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCellWithIdentifier("BeerResultCell", forIndexPath: indexPath)
        if tableView == self.searchResultTableView {
            cell.textLabel?.text = beers![indexPath.row].beerName
        } else {
            cell.textLabel?.text = filteredBeers[indexPath.row].beerName
        }
        
        return cell
        
    }
    
    func makeAPICall() {
         Alamofire.request(.GET, "https://api.untappd.com/v4/search/beer?q=asahi&client_id=32BEBC190F5DE4785EED12F6527239AF2623E77D&client_secret=76BFCCB912EAB5AB2FFC7672C55A5E9530F9492F").responseJSON { response in
                if let json = response.result.value {
                    print ("Connection to API successful!")
                    if let secondJSON = json["response"] as! NSDictionary? {
                        if let beersJSON = secondJSON["beers"] as! NSDictionary? {
                            if let beerItems = beersJSON["items"] as! [NSDictionary]? {
                                var beersJsonArray: [NSDictionary] = []
                                for beerObject in beerItems {
                                    let insideBeerHash = beerObject["beer"]
                                    beersJsonArray.append(insideBeerHash as! NSDictionary)
                                }
                                
                                self.beers = Beer.convertBeers((beersJsonArray as? [NSDictionary]!)!)
                                self.searchResultTableView.reloadData()
                                
                                print (self.beers)
                            }
                        }
                    }
            }
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = searchResultTableView.indexPathForCell(cell)    // narrow down which beer is clicked
        let beer = beers![indexPath!.row]
        
        let beerDetailsController = segue.destinationViewController as! BeerDetailsViewController
        
        beerDetailsController.beer = beer
    }

}
