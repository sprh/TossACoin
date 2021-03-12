//
//  CoinsListViewModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 28.02.2021.
//

import Foundation

// MARK: - ViewModel для экрана со всеми акциями.
class CoinsListViewModel {
    private let enviroment: Enviroment
    private let networkService: NetworkService
    private var coins = [MintedCoin]()
    private var page: Int = 0
    private var type: CoinsListType
    
    // Конструктор.
    init(enviroment: Enviroment, networkService: NetworkService, type: CoinsListType) {
        self.enviroment = enviroment
        self.networkService = networkService
        self.type = type
    }
    
    func getTitle() -> String{
        return type == .all ? "All": "Favourite"
    }
    
    // Получение информации об акциях.
    func getCoins(completion: @escaping () -> Void) {
        switch type {
        case .all:
            networkService.getCoins(page: page) { result in
                switch result {
                case .Success(let mintedCoins):
                    guard mintedCoins.count > 0 else {
                        return completion()
                    }
                    
                    mintedCoins.forEach{ self.coins.append($0) }
                    self.page += 1
                    completion()
                case .Error:
                    print("Error")
                }
            }
        case .favourite:
            let coins = enviroment.favouriteCoins
            networkService.getFavouriteCoins(coins: coins) { result in
                switch result {
                case .Success(let mintedCoins):
                    guard mintedCoins.count > 0 else {
                        return completion()
                    }
                    
                    mintedCoins.forEach{ self.coins.append($0) }
                    completion()
                case .Error:
                    print("Error")
                }
            }
        }
    }
    
    // Настройка ячейки.
    func createCell(cell: CoinCollectionViewCell, at indexPath: Int) {
        if(coins.count <= indexPath) { return }
        let coin = coins[indexPath]
        let coinCellModel = CoinCellModel(coin: coin.coin, priceDisplay: coin.price)
        cell.loadData(model: coinCellModel)
        cell.backgroundColor = indexPath % 2 == 0 ? #colorLiteral(red: 0.989908874, green: 1, blue: 0.9611904025, alpha: 1) : #colorLiteral(red: 0.9994921088, green: 0.9913042188, blue: 0.7818924785, alpha: 1)
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
    
    // Поисковый экран.
    func prepareSearchViewController() -> SearchCoinViewController {
        let searchCoinViewModel = SearchCoinViewModel(enviroment: enviroment, networkService: networkService)
        let searchCoinViewController = SearchCoinViewController(viewModel: searchCoinViewModel)
        return searchCoinViewController
    }
    
    // Для обновления очищается массив полученных ранее монет и подгружаются новые.
    func refresh(completion: @escaping () -> Void) {
        coins = []
        page = 0
        getCoins {
            completion()
        }
    }
}

