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
    private var coins = [Coin]()
    private var page: Int = 0
    
    init(enviroment: Enviroment, networkService: NetworkService) {
        self.enviroment = enviroment
        self.networkService = networkService
    }
    
    // TODO Create data cash and update (refresh control) in the vc scree with a datetime info about last update.
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
        cell.backgroundColor = indexPath % 2 == 0 ? #colorLiteral(red: 0.989908874, green: 1, blue: 0.9611904025, alpha: 1) : #colorLiteral(red: 0.9994921088, green: 0.9913042188, blue: 0.7818924785, alpha: 1)
    }
    
    func getCoinsCount() -> Int {
        return coins.count
    }
    
    func getCoinInfoViewController(cellIndex: Int) -> CoinInfoViewController{
        let coinData = CoinData()
        let viewModel =  CoinInfoViewModel(data: coinData)
        let viewController = CoinInfoViewController(viewModel: viewModel)
        return viewController
    }
    
    func prepareSearchViewController() -> SearchCoinViewController {
        let searchCoinViewModel = SearchCoinViewModel(enviroment: enviroment, networkService: networkService)
        let searchCoinViewController = SearchCoinViewController(viewModel: searchCoinViewModel)
        return searchCoinViewController
    }
}
