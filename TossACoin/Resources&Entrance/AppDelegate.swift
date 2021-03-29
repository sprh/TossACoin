//
//  AppDelegate.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setStatusBarColor()
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBar = TabBarController()
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        return true
    }
    
    func setStatusBarColor() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.tintColor = .black
    }
}

