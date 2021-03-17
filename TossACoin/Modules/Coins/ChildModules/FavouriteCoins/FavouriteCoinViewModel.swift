//
//  FavouriteCoinViewModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 12.03.2021.
//

import Foundation
import UIKit

class FavouriteCoinsViewModel {
    private let enviroment: Enviroment
    private let networkService: NetworkService
    private var coins = [MintedCoin]()
    
    // Конструктор.
    init(enviroment: Enviroment, networkService: NetworkService) {
        self.enviroment = enviroment
        self.networkService = networkService
    }
    
    // Получение информации об акциях.
    func getCoins(completion: @escaping () -> Void) {
        let coins = enviroment.favouriteCoins
        networkService.getFavouriteCoins(coins: coins) { result in
            switch result {
            case .Success(let mintedCoins):
                guard mintedCoins.count > 0 else {
                    return completion()
                }

                self.coins = mintedCoins
                completion()
            case .Error:
                print("Error")
            }
        }
    }
    
    // Настройка ячейки.
    func createCell(cell: CoinCollectionViewCell, at indexPath: Int) {
        if(coins.count <= indexPath) { return }
        let coin = coins[indexPath]
        let coinCellModel = CoinCellModel(coin: coin.coin, priceDisplay: coin.price)
        cell.loadData(model: coinCellModel)
        cell.backgroundColor = indexPath % 2 == 0 ? UIColor(named: "evenCellColorColor") : UIColor(named: "backgroundColor")
    }
    
    // Количество подгруженных акций.
    func getCoinsCount() -> Int {
        return coins.count
    }
    
    // Новый контроллер с информацией об акции.
    func getCoinInfoViewController(cellIndex: Int) -> CoinInfoViewController{
        let viewModel =  CoinInfoViewModel(mintedCoin: coins[cellIndex], enviroment: enviroment, networkService: networkService)
        let viewController = CoinInfoViewController(viewModel: viewModel)
        return viewController
    }
    
    // Для обновления очищается массив полученных ранее монет и подгружаются новые.
    func refresh(completion: @escaping () -> Void) {
        coins = []
        getCoins {
            completion()
        }
    }
}


