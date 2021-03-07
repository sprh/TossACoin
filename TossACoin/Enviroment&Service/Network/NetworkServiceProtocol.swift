//
//  NetworkServiceProtocol.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
// MARK: - Протокол подключения.
protocol NetworkServiceProtocol {
    // Получение всех монет со страницы.
    func getCoins(page: Int, completion: @escaping (NetworkServiceResult<[MintedCoin]>) -> Void)
    // Получение 1 монеты по тикету.
    func getCoin(symbols: [String], completion: @escaping (NetworkServiceResult<[MintedCoin]>) -> Void)
    // Получение цен в различных валютах.
    func getPrices(symbols: String, completion: @escaping (NetworkServiceResult<CoinPrice>) -> Void)
    
    func getDailyPair(symbol: String, completion: @escaping (NetworkServiceResult<CoinPriceForAPeriod>) -> Void)
}
