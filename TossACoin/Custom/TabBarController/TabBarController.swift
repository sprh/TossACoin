//
//  TabController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import UIKit

// TODO: Удалить, если не буду использовать.
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
        
        let enviroment = Enviroment()
        let networkService = NetworkService()
        let coinsContainerVC = createCoinsContainerViewController(enviroment: enviroment, networkService: networkService)
        let searchCoinVC = createSearchCoinViewController(enviroment: enviroment, networkService: networkService)
        viewControllers = [coinsContainerVC, searchCoinVC]
    }
    
    private func createCoinsContainerViewController(enviroment: Enviroment, networkService: NetworkService) -> CoinsContainerViewController{
        let viewModel = CoinsContainerViewModel(enviroment: enviroment, networkService: networkService)
        let viewController = CoinsContainerViewController(viewModel: viewModel)
        viewController.tabBarItem.title = "Coins"
        viewController.tabBarItem.image = UIImage(systemName: "bitcoinsign.circle")?.withTintColor(ApplicationColors.orangeColor)
        viewController.tabBarItem.selectedImage = UIImage(systemName: "bitcoinsign.circle.fill")?.withTintColor(ApplicationColors.lightOrangeColor)
        return viewController
    }
    
    private func createSearchCoinViewController(enviroment: Enviroment, networkService: NetworkService) -> SearchCoinViewController {
        let viewModel = SearchCoinViewModel(enviroment: enviroment, networkService: networkService)
        let viewController = SearchCoinViewController(viewModel: viewModel)
        viewController.tabBarItem.title = "Search"
        viewController.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")?.withTintColor(ApplicationColors.orangeColor)
        viewController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        return viewController
    }
    
    // MARK: - Настройка контроллеров.
    private func setupViewController(title: String, unselectedImage: UIImage, selectedImage: UIImage, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.title = title
        navigationController.navigationItem.title = title
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        // navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    
}
