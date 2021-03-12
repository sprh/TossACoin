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
    // Получение цен в различных валютах.
    func getPrices(symbols: String, completion: @escaping (NetworkServiceResult<CoinPrice>) -> Void)
    // Получение информации о цене за период, указанный в ofType.
    func getPair(symbol: String, ofType: ChartType, completion: @escaping (NetworkServiceResult<CoinPriceForAPeriod>) -> Void)
    // Получение новостей.
    func getNews(symbol: String, completion: @escaping (NetworkServiceResult<NewsData>) -> Void)
    // Получение предложений поиска.
    func getSuggestions(symbol: String, completion: @escaping (NetworkServiceResult<SuggestionResult>) -> Void)
}
