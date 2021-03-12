//
//  CoinInfoModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation

class CoinInfoViewModel {
    var mintedCoin: MintedCoin
    var enviroment: Enviroment
    var networkService: NetworkService
    
    init(mintedCoin: MintedCoin, enviroment: Enviroment, networkService: NetworkService) {
        self.mintedCoin = mintedCoin
        self.enviroment = enviroment
        self.networkService = networkService
    }
    
    // Вьюха с графиком.
    func getChartViewController() -> ChartViewController {
        let viewModel = ChartViewModel(enviroment: enviroment, networkService: networkService, mintedCoin: mintedCoin)
        let mainViewController = ChartViewController(viewModel: viewModel)
        return mainViewController
    }
    
    // Вьюха с новостями.
    func getNewsViewController() -> NewsViewController {
        let viewModel = NewsViewModel(mintedCoin: mintedCoin, enviroment: enviroment, networkService: networkService)
        let newsViewController = NewsViewController(viewModel: viewModel)
        return newsViewController
    }
    
    // Название акции.
    func getCoinName() -> String {
        return mintedCoin.coin.name
    }
    
    // Название компании.
    func getCompanyName() -> String {
        return mintedCoin.coin.fullName
    }
    
    // В избранном ли акция.
    func isFavourite() -> Bool {
        return enviroment.favouriteCoins.contains(mintedCoin.coin.id)
    }
    
    // Добавляние в избранное или удаление из избранного.
    func addToFavourite() {
        if(isFavourite()) {
            if let index = enviroment.favouriteCoins.firstIndex(of: mintedCoin.coin.id) {
                enviroment.favouriteCoins.remove(at: index)
            }
        }
        else {
            enviroment.favouriteCoins.append(mintedCoin.coin.id)
        }
    }
}
