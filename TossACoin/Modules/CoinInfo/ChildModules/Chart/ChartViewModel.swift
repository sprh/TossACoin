//
//  ChartViewModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 07.03.2021.
//

import Foundation
import UIKit

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
    
    public func getName() -> String {
        return mintedCoin.coin.name;
    }
    public func getLastPrice() -> String {
        return mintedCoin.price.price
    }
    
    public func getChangePercent() -> String {
        return mintedCoin.price.changePercent
    }
    
    // Получение данных с сервера.
    private func getPair(ofType: ChartType, complection: @escaping () -> Void) {
        networkService.getPair(symbol: mintedCoin.coin.name, ofType: ofType) {
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
    
    // Получение данных по типу графика.
    public func getData(ofType: ChartType, completion: @escaping ([Double], [String])  -> ()) {
        getPair(ofType: ofType) {
            var seriesData: [Double] = []
            var seriesTime: [String] = []
            // Настройка лейблов и получение значений цены.
            switch ofType {
            // В зависимости от типа выставляется дата.
            case .daily:
                self.coinPriceForAPeriod.data.data.forEach({
                    seriesData.append($0.close); seriesTime.append(Date.getDateFormUnixForDaily(unixTime: Double($0.time)));
                })
            case .hourly, .minute:
                self.coinPriceForAPeriod.data.data.forEach({
                    seriesData.append($0.close); seriesTime.append(Date.getDateFormUnixForMinuteAndHour(unixTime: Double($0.time)));
                })
            }
            completion(seriesData, seriesTime)
        }
    }
    
    public func openBuyCoin() {
        guard let url = URL(string: APIClient.getBuyCoin(symbol: mintedCoin.coin.name)) else {
            return
        }
        UIApplication.shared.open(url)
    }
}
