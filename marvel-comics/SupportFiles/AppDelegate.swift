//
//  AppDelegate.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 07/12/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainCoordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        mainCoordinator = MainCoordinator()
        guard let mainCoordinator = mainCoordinator else { return true }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainCoordinator.initialController
        window?.makeKeyAndVisible()
        
        return true
    }
}

