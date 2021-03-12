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
        
        let enviroment = Enviroment()
        let networkService = NetworkService()
        
        let coinsListViewController = createCoinsListViewController(with: enviroment, with: networkService)
        let coinsListNavigationController = setupViewController(title: "Coins", unselectedImage: UIImage(systemName: "bitcoinsign.circle")!, selectedImage: UIImage(systemName: "bitcoinsign.circle.fill")!, viewController: coinsListViewController)
        viewControllers = [coinsListNavigationController]
    }
    
    // MARK: Контроллер со всеми акциями.
    private func createCoinsListViewController(with enviroment: Enviroment, with networkService: NetworkService) -> CoinsListViewController {
        let viewModel = CoinsListViewModel(enviroment: enviroment, networkService: networkService)
        let viewController = CoinsListViewController(viewModel: viewModel)
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
