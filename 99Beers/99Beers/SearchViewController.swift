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
    
    // variables for search function
    var filteredBeers = [Beer]()
    var shouldShowSearchResults = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createSearchBar()
        makeAPICall()
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
    
    func createSearchBar() {
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Anchor Steam"
        searchBar.delegate = self
        
        // put into navigation bar
        self.navigationItem.titleView = searchBar
    }
    
    // Functions for adding search
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredBeers = (beers?.filter({ (beer: Beer) -> Bool in
            return beer.beerName?.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
        }))!
        
        if searchText != "" {
            shouldShowSearchResults = true
            self.searchResultTableView.reloadData()
        } else {
            shouldShowSearchResults = false
            self.searchResultTableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredBeers.count
        } else {
            return beers!.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCellWithIdentifier("BeerResultCell", forIndexPath: indexPath)
        if shouldShowSearchResults {
            cell.textLabel?.text = filteredBeers[indexPath.row].beerName
        } else {
            cell.textLabel?.text = beers![indexPath.row].beerName
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
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        searchBar.endEditing(true)
        
        self.searchResultTableView.reloadData()
    }

}
