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
    
    func getCoinsListViewController(type: CoinsListType) -> CoinsListViewController {
        let viewModel = CoinsListViewModel(enviroment: enviroment, networkService: networkService, type: type)
        let viewConteoller = CoinsListViewController(viewModel: viewModel)
        return viewConteoller
    }
}
