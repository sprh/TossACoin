//
//  CoinInfoModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation

class CoinInfoViewModel {
    var data: MintedCoin
    var enviroment: Enviroment
    var networkService: NetworkService
    
    init(data: MintedCoin, enviroment: Enviroment, networkService: NetworkService) {
        self.data = data
        self.enviroment = enviroment
        self.networkService = networkService
    }
}
