//
//  TabController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import UIKit

// MARK: - Application's Tab Bar.
public final class TabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Инициализация контроллеров.
    private func setup() {
        tabBar.tintColor = .orange
        tabBar.barTintColor = UIColor(named: "navigationAndTopColor")
        
        let enviroment = Enviroment()
        let networkService = NetworkService()
        let coinsContainerVC = createCoinsContainerViewController(enviroment: enviroment, networkService: networkService)
        let searchCoinVC = createSearchCoinViewController(enviroment: enviroment, networkService: networkService)
        viewControllers = [coinsContainerVC, searchCoinVC]
    }
    
    private func createCoinsContainerViewController(enviroment: Enviroment, networkService: NetworkService) -> UINavigationController {
        let viewModel = CoinsContainerViewModel(enviroment: enviroment, networkService: networkService)
        let viewController = CoinsContainerViewController(viewModel: viewModel)
        viewController.tabBarItem.title = "Coins"
        viewController.tabBarItem.image = UIImage(systemName: "bitcoinsign.circle")?.withTintColor(.orangeColor)
        viewController.tabBarItem.selectedImage = UIImage(systemName: "bitcoinsign.circle.fill")?.withTintColor(.lightOrangeColor)
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    private func createSearchCoinViewController(enviroment: Enviroment, networkService: NetworkService) -> UINavigationController {
        let viewModel = SearchCoinViewModel(enviroment: enviroment, networkService: networkService)
        let viewController = SearchCoinViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem.title = "Search"
        viewController.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")?.withTintColor(.orangeColor)
        viewController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        return navigationController
    }
}
