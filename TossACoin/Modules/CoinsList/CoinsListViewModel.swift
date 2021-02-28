//
//  CoinsListViewModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 28.02.2021.
//

import Foundation

class CoinsListViewModel {
    private let enviroment: Enviroment
    private let networkService: NetworkService
    private var initialCurrency: String
    private var coins = [Coin]()
    private var page: Int = 0
    
    init(enviroment: Enviroment, networkService: NetworkService) {
        self.enviroment = enviroment
        self.networkService = networkService
        self.initialCurrency = enviroment.currency
    }
    
    func getCoins(completion: @escaping () -> Void) {
        networkService.getCoins(page: page) { [weak self] result in
            guard let `self` = self else { return }

            switch result {
            case .Success(let constructedCoins):
                guard constructedCoins.count > 0 else {
                    return completion()
                }
                
                constructedCoins.forEach{ self.coins.append($0) }
                self.page += 1
                completion()
            case .Error:
                print("Error")
            }
        }
    }
    
    func createCell(cell: CoinCollectionViewCell, at indexPath: Int) {
        if(coins.count <= indexPath) { return }
        let coin = coins[indexPath]
        let coinCellModel = CoinCellModel(coin: coin)
        cell.loadData(model: coinCellModel)
    }
    
    func getCoinsCount() -> Int {
        return coins.count
    }
}
