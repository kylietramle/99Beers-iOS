//
//  Beer.swift
//  99Beers
//
//  Created by Kylie Tram Le on 10/14/16.
//  Copyright © 2016 Kylie Tram Le. All rights reserved.
//

import Foundation

class Beer {
    
    var beerName: String? = nil
    var beerLogo: String? = nil
    var beerStyle: String? = nil
    var abv: Float = 0.0
    var ibu: Float = 0.0
    var beerDescription: String? = nil
    
    // initialize Beer instance
    class func newBeer(_ beerDictionary: NSDictionary) -> Beer {
        
        let beer = Beer()
        
        beer.beerName = beerDictionary["beer_name"] as? String
        
        beer.beerLogo = beerDictionary["beer_label"] as? String
        
        beer.beerStyle = beerDictionary["beer_style"] as? String
        
        beer.abv = beerDictionary["beer_abv"] as! Float
        
        beer.ibu = beerDictionary["beer_ibu"] as! Float
        
        beer.beerDescription = beerDictionary["beer_description"] as? String ?? nil
        
        return beer
    }

    
    // take array of JSON movie objects and turn it to our Movie class objects
    class func convertBeers(_ jsonArray: [NSDictionary]) -> [Beer] {
        var beers = [Beer]()  // empty beers array that will contain Beer objects
        
        for jsonDictionary in jsonArray {
            let beer = newBeer(jsonDictionary)   // init method
                
//            print("New Beer saved with name: \(beer.beerName)")
            beers.append(beer)
        }
        
        return beers
    }
}
    

