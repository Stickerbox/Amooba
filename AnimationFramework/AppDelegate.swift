//
//  AppDelegate.swift
//  AnimationFramework
//
//  Created by Jordan.Dixon on 01/08/2017.
//  Copyright © 2017 Jordan Dixon. All rights reserved.
//

import UIKit

/// The delegate of the application.
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// The window of the application.
    var window: UIWindow?


    /// Tells the delegate that the launch process is almost done and the app is almost ready to run.
    ///
    /// - Parameters:
    ///   - application: The singleton app object.
    ///   - launchOptions: A dictionary indicating the reason the app was launched (if any).
    /// - Returns: `true` if the app handles the URL request, otherwise `false`.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    /// Tells the delegate that the app is about to become inactive.
    ///
    /// - Parameter application: The singleton app object.
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    /// Tells the delegate that the app is now in the background.
    ///
    /// - Parameter application: The singleton app object.
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    /// Tells the delegate that the app is about to enter the foreground.
    ///
    /// - Parameter application: The singleton app object.
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    /// Tells the delegate that the app has become active.
    ///
    /// - Parameter application: The singleton app object.
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    /// Tells the delegate that the app is about to terminate.
    ///
    /// - Parameter application: The singleton app object.
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
