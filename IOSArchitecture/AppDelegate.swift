//
//  AppDelegate.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit
import LocalAuthentication



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: HomeCoordinatorManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUG
        // UI Tests only : ProcessInfo.underUITests,
        if let viewModelString = ProcessInfo.processInfo.environment["viewModelInjector"] {
            let viewModelInjector = try! JSONDecoder.neoDecoder.decode(ViewModelInjector.self, from: viewModelString.data(using: .utf8)!)
            let viewController = viewModelInjector.getRootViewController()
            
            if window == nil {
                window = UIWindow(frame: UIScreen.main.bounds)
            }
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
            return true
        }
        #endif
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        appCoordinator = HomeCoordinatorManager(window: window)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Deep link
        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        BiometryWorker(biometryProvider: LAContext()).checkChanges()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

