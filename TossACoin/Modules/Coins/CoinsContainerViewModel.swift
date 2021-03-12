//
//  CoinsContainerViewModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 12.03.2021.
//

import Foundation


class CoinsContainerViewModel {
    private let enviroment: Enviroment
    private let networkService: NetworkService
    
    // Конструктор.
    init(enviroment: Enviroment, networkService: NetworkService) {
        self.enviroment = enviroment
        self.networkService = networkService
    }
    
    func getAllCoinsViewController() -> AllCoinsViewController {
        let viewModel = AllCoinsViewModel(enviroment: enviroment, networkService: networkService)
        let viewController = AllCoinsViewController(viewModel: viewModel)
        return viewController
    }
    
    func getFavouriteCoinsViewController() -> FavouriteCoinsViewController {
        let viewModel = FavouriteCoinsViewModel(enviroment: enviroment, networkService: networkService)
        let viewController = FavouriteCoinsViewController(viewModel: viewModel)
        return viewController
    }
}
