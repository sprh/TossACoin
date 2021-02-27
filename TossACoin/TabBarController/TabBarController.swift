//
//  TabController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import UIKit

public final class TabBarController: UITabBarController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set view controllers.
    private func setup() {
        let stocksListContext = StocksListContext()
        let stocksListContainer = StocksListContainer.assemble(with: stocksListContext)
        var stocksListNavigationController = UINavigationController(rootViewController: stocksListContainer.viewController)
        stocksListNavigationController = setupNavigationController(title: "Stocks", unselectedImage: UIImage(systemName: "bitcoinsign.circle")!, selectedImage: UIImage(systemName: "bitcoinsign.circle.fill")!, navigationController: stocksListNavigationController)
        
        stocksListContainer.viewController.loadViewIfNeeded()
        
        viewControllers = [stocksListNavigationController]
    }
    
    private func setupNavigationController(title: String, unselectedImage: UIImage, selectedImage: UIImage, navigationController: UINavigationController) -> UINavigationController{
        navigationController.tabBarItem.title = title
        navigationController.navigationItem.title = title
        navigationController.navigationBar.topItem?.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        navigationController.navigationBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return navigationController
    }
    
}
