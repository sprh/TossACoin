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
    
    func getMainViewController() -> MainInfoViewController {
        let viewModel = MainInfoViewModel(enviroment: enviroment, networkService: networkService, symbol: mintedCoin.coin.name)
        let mainViewController = MainInfoViewController(viewModel: viewModel)
        return mainViewController
    }
    
    func getCoinName() -> String {
        return mintedCoin.coin.name
    }
    
    func getCompanyName() -> String {
        return mintedCoin.coin.fullName
    }
    
    func isFavourite() -> Bool {
        return enviroment.favouriteCoins.contains(mintedCoin.coin.id)
    }
    
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
