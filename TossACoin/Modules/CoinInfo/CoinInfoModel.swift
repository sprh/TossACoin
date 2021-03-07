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
    
    func getMainViewController() {
        
    }
    
    func getCoinName() -> String {
        return mintedCoin.coin.name
    }
    
    func getCompanyName() -> String {
        return mintedCoin.coin.fullName
    }
}
