//
//  Beer.swift
//  99Beers
//
//  Created by Kylie Tram Le on 10/14/16.
//  Copyright © 2016 Kylie Tram Le. All rights reserved.
//

import Foundation
import RealmSwift

class Beer: Object {
    
    var beerName: String? = nil
    var beerLogo: NSURL? = nil
    var beerStyle: String? = nil
    var abv: Float? = nil
    var ibu: Float? = nil
    var brewery: String? = nil
    var beerDescription: String? = nil
    
    // initialize Beer instance
    class func newBeer(beerDictionary: NSDictionary) -> Beer {
        
        let beer = Beer()
        
        beer.beerName = beerDictionary["beer"]!["beer_name"]
        print(beer.beerName)
        
        if let beerLogo = beerDictionary["beer"]["beer_label"] as? NSURL {
        } else {
            beer.beerLogo = nil
        }
        
        beer.beerStyle = beerDictionary["beer"]["beer_style"] as? String
        
        beer.abv = beerDictionary["beer"]["beer_abv"] as? Float
        
        beer.ibu = beerDictionary["beer"]["beer_ibu"] as? Float
        
        beer.brewery = beerDictionary["brewery"]["brewery_name"] as? String
        print(beer.brewery)
        
        beer.beerDescription = beerDictionary["beer"]["beer_description"] as? String
        
        return beer
    }
    
    // take array of JSON beer objects and turn it to our Beer class objects
    class func convertBeers(jsonArray: [NSDictionary]) -> [Beer] {
        var beers = [Beer]()  // empty beers array that will contain Beer objects
        
        for jsonDictionary in jsonArray {
            let beer = newBeer(jsonDictionary)   // init method
            try! realmObject.write() {
                realmObject.add(beer)
                
                print("New Beer saved with name: \(beer.beerName)")
                beers.append(beer)
            }
        }
        return beers
    }

}