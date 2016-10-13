//
//  AppDelegate.swift
//  99Beers
//
//  Created by Kylie Tram Le on 10/8/16.
//  Copyright © 2016 Kylie Tram Le. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //Search bar button
        let searchNavigationController = storyboard.instantiateViewControllerWithIdentifier("SearchNavigationController") as! UINavigationController
        searchNavigationController.tabBarItem.title = "Search"
        searchNavigationController.tabBarItem.image = UIImage(named: "search")
        
        //Bar feed bar button
        let barFeedNavigationController = storyboard.instantiateViewControllerWithIdentifier("BarFeedNavigationController") as! UINavigationController
        barFeedNavigationController.tabBarItem.title = "Bar Feed"
        barFeedNavigationController.tabBarItem.image = UIImage(named: "barfeed")
        
        //Trophy wall bar button
        let trophyWallNavigationController = storyboard.instantiateViewControllerWithIdentifier("TrophyWallNavigationController") as! UINavigationController
        trophyWallNavigationController.tabBarItem.title = "Trophy Wall"
        trophyWallNavigationController.tabBarItem.image = UIImage(named: "trophy wall")

        //Account bar button
        let accountNavigationController = storyboard.instantiateViewControllerWithIdentifier("AccountNavigationController") as! UINavigationController
        accountNavigationController.tabBarItem.title = "Account"
        accountNavigationController.tabBarItem.image = UIImage(named: "search")
        
        //setup tabbar controller - add tab bar buttons
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [searchNavigationController, barFeedNavigationController, trophyWallNavigationController, accountNavigationController]
        UITabBar.appearance().tintColor = UIColor.redColor()
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
       
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

