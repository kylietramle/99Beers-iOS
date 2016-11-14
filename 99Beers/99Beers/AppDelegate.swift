//
//  AppDelegate.swift
//  99Beers
//
//  Created by Kylie Tram Le on 10/8/16.
//  Copyright © 2016 Kylie Tram Le. All rights reserved.
//

import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
        
        window?.rootViewController = initialViewController
        
        // FB SDK
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //Search bar button
        let searchNavigationController = storyboard.instantiateViewController(withIdentifier: "SearchNavigationController") as! UINavigationController
        searchNavigationController.tabBarItem.title = "Search"
        searchNavigationController.tabBarItem.image = UIImage(named: "search")
        
        //Bar feed bar button
        let barFeedNavigationController = storyboard.instantiateViewController(withIdentifier: "BarFeedNavigationController") as! UINavigationController
        barFeedNavigationController.tabBarItem.title = "Bar Feed"
        barFeedNavigationController.tabBarItem.image = UIImage(named: "barfeed")
        
        //Trophy wall bar button
        let trophyWallNavigationController = storyboard.instantiateViewController(withIdentifier: "TrophyWallNavigationController") as! UINavigationController
        trophyWallNavigationController.tabBarItem.title = "Trophy Wall"
        trophyWallNavigationController.tabBarItem.image = UIImage(named: "trophy wall")

        //Account bar button
        let accountNavigationController = storyboard.instantiateViewController(withIdentifier: "AccountNavigationController") as! UINavigationController
        accountNavigationController.tabBarItem.title = "Account"
        accountNavigationController.tabBarItem.image = UIImage(named: "search")
        
        //setup tabbar controller - add tab bar buttons
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [searchNavigationController, barFeedNavigationController, trophyWallNavigationController, accountNavigationController]
        UITabBar.appearance().tintColor = UIColor.red
        UITabBar.appearance().barTintColor = UIColor.black
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // FB SDK
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

