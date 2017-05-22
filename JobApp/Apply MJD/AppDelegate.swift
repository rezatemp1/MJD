//
//  AppDelegate.swift
//  Apply MJD
//
//  Created on 12/12/16.
//  Copyright © 2016 MJD Interactive. All rights reserved.
//

import UIKit
import DataManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      self.window = UIWindow(frame: UIScreen.main.bounds)
      
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      
      let initialViewController = storyboard.instantiateViewController(withIdentifier: "CatListingTableViewController") as! CatListingTableViewController
      initialViewController.clientApi = HTTPAPIClient()
      
      self.window?.rootViewController = initialViewController
      self.window?.makeKeyAndVisible()
      
      return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }


}

