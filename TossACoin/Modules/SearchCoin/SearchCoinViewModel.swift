//
//  SearchCoinViewModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation
import UIKit

class SearchCoinViewModel {
    fileprivate var enviroment: Enviroment
    fileprivate var networkService: NetworkService
    fileprivate var suggestions: [MintedCoin] = []
    
    init(enviroment: Enviroment, networkService: NetworkService) {
        self.enviroment = enviroment
        self.networkService = networkService
    }
    
    func getSuggestions(symbol: String, completion: @escaping () -> Void) {
        networkService.getSuggestions(symbol: symbol) { (result) in
            switch result {
            case .Success(let suggestions):
                self.suggestions = suggestions
                completion()
            case .Error:
                self.suggestions = []
                completion()
            }
        }
    }
    
    func getSuggestionsCount() -> Int{
        return suggestions.count
    }
    
    func getCoinInfoViewController(cellIndex: Int) -> CoinInfoViewController{
        let viewModel =  CoinInfoViewModel(mintedCoin: suggestions[cellIndex], enviroment: enviroment, networkService: networkService)
        let viewController = CoinInfoViewController(viewModel: viewModel)
        return viewController
    }
    
    func createCell(cell: CoinCollectionViewCell, at indexPath: Int) {
        if(suggestions.count <= indexPath) { return }
        let coin = suggestions[indexPath]
        let coinCellModel = CoinCellModel(coin: coin.coin, priceDisplay: coin.price)
        cell.loadData(model: coinCellModel)
        cell.backgroundColor = indexPath % 2 == 0 ? UIColor(named: "evenCellColorColor") : UIColor(named: "backgroundColor")
    }
    
    func addNewSearchingRequest(text: String) {
        if (text != "" && !enviroment.searchingRequests.contains(text)) {
            enviroment.searchingRequests.append(text)
            print(enviroment.searchingRequests)
        }
    }
    
    func getOldRequests() -> [String] {
        return enviroment.searchingRequests
    }
}
