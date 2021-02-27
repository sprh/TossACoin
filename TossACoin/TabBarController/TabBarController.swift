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
        let stocksListNC = UINavigationController(rootViewController: stocksListContainer.viewController)
        stocksListNC.tabBarItem.title = "Stocks"
        stocksListNC.tabBarItem.image = UIImage(systemName: "star")
        stocksListContainer.viewController.loadViewIfNeeded()
        
        viewControllers = [stocksListNC]
    }
    
    
}
