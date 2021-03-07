//
//  MainInfoViewModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 07.03.2021.
//

import Foundation
import SwiftChart

class MainInfoViewModel {
    let enviroment: Enviroment
    let networkService: NetworkService
    var coinPriceForAPeriod = CoinPriceForAPeriod()
    let symbol: String
    
    init(enviroment: Enviroment, networkService: NetworkService, symbol: String) {
        self.enviroment = enviroment
        self.networkService = networkService
        self.symbol = symbol
    }
    
    private func getDailyPair(complection: @escaping () -> Void) {
        networkService.getDailyPair(symbol: symbol) {
            [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
                case .Success(let dailyPairs):
                    self.coinPriceForAPeriod = dailyPairs
                    complection()
            case .Error:
                print("Error")
            }
        }
    }
    
    public func getData(ofType: ChartType, completion: @escaping ([Double])  -> ()) {
        switch ofType {
        case .daily:
            getDailyPair {
                var seriesData: [Double] = []
                self.coinPriceForAPeriod.data.data.forEach({ seriesData.append($0.close) })
                completion(seriesData)
            }
        }
    }
}
