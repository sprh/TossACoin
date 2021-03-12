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
        window = UIWindow(frame: UIScreen.main.bounds)
        let enviroment = Enviroment()
        let networkService = NetworkService()
        let viewModel = CoinsContainerViewModel(enviroment: enviroment, networkService: networkService)
        let viewController = CoinsContainerViewController(viewModel: viewModel)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }


}

