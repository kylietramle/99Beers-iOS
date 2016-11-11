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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        makeAPICall(searchBar.text!)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.searchResultTableView.reloadData()
    }
    
    // End of search bars
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return beers!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "BeerResultCell", for: indexPath)
        cell.textLabel?.text = beers![indexPath.row].beerName
        
        return cell
    }
    
    func makeAPICall(_ beer: String) {
        print("THE SEARCHED BEER IS \(beer)")
        let apiEndpoint: String = "https://api.untappd.com/v4/search/beer?q=\(beer)&client_id=32BEBC190F5DE4785EED12F6527239AF2623E77D&client_secret=76BFCCB912EAB5AB2FFC7672C55A5E9530F9492F"
         Alamofire.request(apiEndpoint).responseJSON { response in
                if let json = response.result.value {
                    print ("Connection to API successful!")
//                    print (json)
                    print (Mirror(reflecting: json))
                    if let responseJSON = (json as AnyObject)["response"] as? NSDictionary {
                        if let beersJSON = (responseJSON as AnyObject)["beers"] as? NSDictionary {
//                                print(beersJSON)
                                print (Mirror(reflecting: beersJSON))
                            if let beerItems = (beersJSON as AnyObject)["items"] as? [NSDictionary] {
                                print (Mirror(reflecting: beerItems))
                                var beersJsonArray: [NSDictionary] = []
                                for beerObject in beerItems {
                                    let insideBeerHash = beerObject["beer"]
                                    beersJsonArray.append(insideBeerHash as! NSDictionary)
                                }
                                
                                self.beers = Beer.convertBeers((beersJsonArray as [NSDictionary]!)!)
                                print(self.beers!)
                                self.searchResultTableView.reloadData()
//
                            }
                       }
                    }
            }
            
        }
    }
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = searchResultTableView.indexPath(for: cell)    // narrow down which beer is clicked
        let beer = beers![indexPath!.row]
        
        let beerDetailsController = segue.destination as! BeerDetailsViewController
        
        beerDetailsController.beer = beer
    }

}
