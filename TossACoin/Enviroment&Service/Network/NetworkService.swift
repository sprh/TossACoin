//
//  NetworkService.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
import Alamofire

// MARK: - Подключение.
public struct NetworkService: NetworkServiceProtocol {
    private let decoder = JSONDecoder()
    
    func getSuggestions(symbol: String, completion: @escaping (NetworkServiceResult<[MintedCoin]>) -> Void) {
        guard let url = URL(string: APIClient.getSuggestions(symbol: symbol)) else { return }
        
        AF.request(url).responseData { (dataRespose) in
            if let error = dataRespose.error {print(error); return }
            
            guard let data = dataRespose.data else { return }
            do {
                let result = try self.decoder.decode(SuggestionResult.self, from: data)
                // Все предложения.
                var coins = result.suggestions
                coins.removeAll(where: {$0.symbol == ""})
                let coinSymbols = coins.map({ $0.symbol }).joined(separator: ",")
                var mintedCouns = [MintedCoin]()
                
                self.getPrices(symbols: coinSymbols, completion: { result in
                    switch result {
                    case .Success(let coinPrices):
                        coins.forEach {
                            // Запрос цены.
                            guard let price = coinPrices.display[$0.symbol] else { return }
                            // Переделываем в монеты.
                            let coin = Coin(id: $0.id, name: $0.symbol, fullName: $0.name, imageUrl: $0.imageUrl)
                            mintedCouns.append(MintedCoin(coin: coin, price: price["USD"] ?? CoinPriceDisplay()))
                        }
                        // Вызов замыкания.
                        completion(.Success(mintedCouns))
                    case .Error(let error):
                        print(error)
                        completion(.Error(error))
                    }
                })
            } catch let error {
                print(error)
            }
        }
    }
    
    func getNews(symbol: String, completion: @escaping (NetworkServiceResult<NewsData>) -> Void) {
        guard let url = URL(string: APIClient.getNews(symbol: symbol)) else { return }
        AF.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {print(error); return}
            guard let data = dataResponse.data else {return}
            do {
                let result = try self.decoder.decode(NewsData.self, from: data)
                completion(.Success(result))
            } catch let error {
                print(error)
            }
        }
    }
    
    func getPair(symbol: String, ofType: ChartType, completion: @escaping (NetworkServiceResult<CoinPriceForAPeriod>) -> Void) {
        let url: URL
        // Тип запрашиваемого графика.
        switch ofType {
        case .daily:
            guard let urlForSymbol = URL(string: APIClient.getDailyPair(symbol: symbol)) else { return }
            url = urlForSymbol
        case .hourly:
            guard let urlForSymbol = URL(string: APIClient.getHourlyPair(symbol: symbol)) else { return }
            url = urlForSymbol
        case .minute:
            guard let urlForSymbol = URL(string: APIClient.getMinutePair(symbol: symbol)) else { return }
            url = urlForSymbol
        }
        
        // Подключение церез Alamofire.
        AF.request(url).responseData { (dataResponse) in
            // Обработка ошибок.
            if let error = dataResponse.error {print(error); return }
            guard let data = dataResponse.data else { print("error data"); return }
            
            do {
                let result = try self.decoder.decode(CoinPriceForAPeriod.self, from: data)
                // Вызов замыкания.
                completion(.Success(result))
            }
            catch let error {
                print(error)
            }
        }
    }
    
    func getPrices(symbols: String, completion: @escaping (NetworkServiceResult<CoinPrice>) -> Void) {
        guard let url = URL(string: APIClient.getPrices(symbols: symbols)) else { return }
        
        // Подключение церез Alamofire.
        AF.request(url).responseData { (dataResponse) in
            // Обработка ошибок.
            if let error = dataResponse.error {print(error); return }
            guard let data = dataResponse.data else { print("error data"); return }
            
            do {
                let result = try self.decoder.decode(CoinPrice.self, from: data)
                // Вызов замыкания.
                completion(.Success(result))
            }
            catch let error {
                completion(.Error(error))
            }
        }

    }
    
    func getCoins(page: Int, completion: @escaping (NetworkServiceResult<[MintedCoin]>) -> Void) {
        guard let url = URL(string: APIClient.getCoins(page: page)) else { print("Get coins url error"); return }

        // Подключение церез Alamofire.
        AF.request(url).responseData { (dataResponse) in
            // Обработка ошибок.
            if let error = dataResponse.error { print(error); return}
            
            guard let data = dataResponse.data else { print("error data"); return }

            do {
                let result = try self.decoder.decode(ResultCoins.self, from: data)
                // Все монеты.
                let coins = result.data.map({ $0.coin })
                // Все тикеты.
                let coinSymbols = coins.map({ $0.name }).joined(separator: ",")

                var mintedCouns = [MintedCoin]()
                
                self.getPrices(symbols: coinSymbols, completion: { result in
                    switch result {
                    case .Success(let coinPrices):
                        coins.forEach {
                            guard let price = coinPrices.display[$0.name] else { return }
                            // Из forEach берем акцию, затем проверяем цену.
                            // Если она не имеет информации о валюте, создаем CoinPriceDisplay с помощью безпараметрического конструктора
                            mintedCouns.append(MintedCoin(coin: $0, price: price["USD"] ?? CoinPriceDisplay()))
                        }
                        // Вызов замыкания.
                        completion(.Success(mintedCouns))
                    case .Error:
                        return
                    }
                })
            }
            catch let error {
                print(error)
            }
        }
    }
    
    func getFavouriteCoins(coins: [Coin], completion: @escaping (NetworkServiceResult<[MintedCoin]>) -> Void) {
        let coinSymbols = coins.map({ $0.name }).joined(separator: ",")
        var mintedCouns = [MintedCoin]()
        
        self.getPrices(symbols: coinSymbols, completion: { result in
            switch result {
            case .Success(let coinPrices):
                coins.forEach {
                    guard let price = coinPrices.display[$0.name] else { return }
                    // Из forEach берем акцию, затем проверяем цену.
                    // Если она не имеет информации о валюте, создаем CoinPriceDisplay с помощью безпараметрического конструктора
                    mintedCouns.append(MintedCoin(coin: $0, price: price["USD"] ?? CoinPriceDisplay()))
                }
                // Вызов замыкания.
                completion(.Success(mintedCouns))
            case .Error:
                return
            }
        })
    }
}
