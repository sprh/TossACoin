//
//  CoinListFavouriteCoinsViewModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation

class CoinListFavouriteCoinsViewModel {
    let enviroment: Enviroment
    let networkService: NetworkService
    
    init(enviroment: Enviroment, networkService: NetworkService) {
        self.enviroment = enviroment
        self.networkService = networkService
    }
}
