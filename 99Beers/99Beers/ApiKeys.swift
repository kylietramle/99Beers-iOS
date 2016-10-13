//
//  ApiKeys.swift
//  99Beers
//
//  Created by Kylie Tram Le on 10/13/16.
//  Copyright © 2016 Kylie Tram Le. All rights reserved.
//

import Foundation

func valueForAPIKey(keyname keyname:String) -> AnyObject {
    let filePath = NSBundle.mainBundle().pathForResource("ApiKeys", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value:AnyObject = (plist?.objectForKey(keyname))!
    
    return value
}
