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

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchResultTableView: UITableView!
    
    let searchBar = UISearchBar()
    var beers: [Beer]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createSearchBar()
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
    }
    // Functions for adding search
    func createSearchBar() {
        searchBar.placeholder = "Anchor Steam"
        searchBar.delegate = self
        
        // put into navigation bar
        self.navigationItem.titleView = searchBar
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        makeAPICall(searchBar.text!)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.searchResultTableView.reloadData()
    }
    
    // End of search bars
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return beers!.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCellWithIdentifier("BeerResultCell", forIndexPath: indexPath)
        cell.textLabel?.text = beers![indexPath.row].beerName
        
        return cell
    }
    
    func makeAPICall(beer: String) {
        print("THE SEARCHED BEER IS \(beer)")
        let apiEndpoint: String = "https://api.untappd.com/v4/search/beer?q=\(beer)&client_id=32BEBC190F5DE4785EED12F6527239AF2623E77D&client_secret=76BFCCB912EAB5AB2FFC7672C55A5E9530F9492F"
         Alamofire.request(.GET, apiEndpoint).responseJSON { response in
                if let json = response.result.value {
                    print ("Connection to API successful!")
                    if let secondJSON = json["response"] {
                        if let beersJSON = secondJSON!["beers"] {
                            if let beerItems = beersJSON!["items"] as? [NSDictionary] {
                                var beersJsonArray: [NSDictionary] = []
                                for beerObject in beerItems {
                                    let insideBeerHash = beerObject["beer"]
                                    beersJsonArray.append(insideBeerHash as! NSDictionary)
                                }
                                
                                self.beers = Beer.convertBeers((beersJsonArray as [NSDictionary]!)!)
                                print(self.beers)
                                self.searchResultTableView.reloadData()

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
