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
    var beerLogo: String? = nil
    var beerStyle: String? = nil
    var abv: Float? = nil
    var ibu: Float? = nil
    var beerDescription: String? = nil
    
    // initialize Beer instance
    class func newBeer(beerDictionary: NSDictionary) -> Beer {
        
        let beer = Beer()
        
        beer.beerName = beerDictionary["beer_name"] as? String
        
        if (beerDictionary["beer_label"] as? NSURL) != nil {
        } else {
            beer.beerLogo = nil
        }
        
        beer.beerStyle = beerDictionary["beer_style"] as? String
        
        beer.abv = beerDictionary["beer_abv"] as? Float
        
        beer.ibu = beerDictionary["beer_ibu"] as? Float
        
        beer.beerDescription = beerDictionary["beer_description"] as? String
        
        return beer
    }
    
    // take array of JSON movie objects and turn it to our Movie class objects
    class func convertBeers(jsonArray: [NSDictionary]) -> [Beer] {
        var beers = [Beer]()  // empty beers array that will contain Beer objects
        
        for jsonDictionary in jsonArray {
            let beer = newBeer(jsonDictionary)   // init method
                
            print("New Beer saved with name: \(beer.beerName)")
            beers.append(beer)
        }
        
        return beers
    }
}
    

