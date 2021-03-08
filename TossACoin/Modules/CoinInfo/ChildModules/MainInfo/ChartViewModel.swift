//
//  ChartViewModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 07.03.2021.
//

import Foundation
import SwiftChart

class ChartViewModel {
    let enviroment: Enviroment
    let networkService: NetworkService
    var coinPriceForAPeriod = CoinPriceForAPeriod()
    let mintedCoin: MintedCoin
    
    init(enviroment: Enviroment, networkService: NetworkService, mintedCoin: MintedCoin) {
        self.enviroment = enviroment
        self.networkService = networkService
        self.mintedCoin = mintedCoin
    }
    
    public func getLastPrice() -> String {
        return mintedCoin.price.price
    }
    
    public func getChangePercent() -> String {
        return mintedCoin.price.changePercent
    }
    
    private func getDailyPair(complection: @escaping () -> Void) {
        networkService.getDailyPair(symbol: mintedCoin.coin.name) {
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
    
    private func getHourlyPair(complection: @escaping () -> Void) {
        networkService.getHourlyPair(symbol: mintedCoin.coin.name) {
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
    
    private func getMinutePair(complection: @escaping () -> Void) {
        networkService.getMinutePair(symbol: mintedCoin.coin.name) {
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
        case .hourly:
            getHourlyPair {
                var seriesData: [Double] = []
                self.coinPriceForAPeriod.data.data.forEach({ seriesData.append($0.close) })
                completion(seriesData)
            }
        case .minute:
            getMinutePair {
                var seriesData: [Double] = []
                self.coinPriceForAPeriod.data.data.forEach({ seriesData.append($0.close) })
                completion(seriesData)
            }
        }
    }
    
    public func openBuyCoin() {
        guard let url = URL(string: APIClient.getBuyCoin(symbol: mintedCoin.coin.name)) else {
            return
        }
        UIApplication.shared.open(url)
    }
}