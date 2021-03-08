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
    func getHourlyPair(symbol: String, completion: @escaping (NetworkServiceResult<CoinPriceForAPeriod>) -> Void) {
        guard let url = URL(string: APIClient.getHourlyPair(symbol: symbol)) else { return }
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
            catch let error { print(error) }
        }
    }
    
    func getMinutePair(symbol: String, completion: @escaping (NetworkServiceResult<CoinPriceForAPeriod>) -> Void) {
        guard let url = URL(string: APIClient.getMinutePair(symbol: symbol)) else { return }
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
            catch let error { print(error) }
        }
    }
    
    func getDailyPair(symbol: String, completion: @escaping (NetworkServiceResult<CoinPriceForAPeriod>) -> Void) {
        guard let url = URL(string: APIClient.getDailyPair(symbol: symbol)) else { return }
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
            catch let error { print(error) }
        }
    }
    
    func getCoin(symbols: [String], completion: @escaping (NetworkServiceResult<[MintedCoin]>) -> Void) {
        
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
            catch let error { print(error) }
        }

    }
    
    private let decoder = JSONDecoder()
    
    
    func getCoins(page: Int, completion: @escaping (NetworkServiceResult<[MintedCoin]>) -> Void) {
        guard let url = URL(string: APIClient.getCoins(page: page)) else { print("Get coins url error"); return }

        // Подключение церез Alamofire.
        AF.request(url).responseData { (dataResponse) in
            // Обработка ошибок.
            if let error = dataResponse.error { print(error); return}
            
            guard let data = dataResponse.data else { print("error data"); return }

            do {
                let result = try self.decoder.decode(ResultCoins.self, from: data)
                // Все тикеты.
                let coinSymbols = result.data.map({ $0.coin.name }).joined(separator: ",")
                // Все монеты.
                let coins = result.data.map({ $0.coin })

                var mintedCouns = [MintedCoin]()
                
                self.getPrices(symbols: coinSymbols, completion: { result in
                    switch result {
                    case .Success(let coinPrices):
                        coins.forEach {
                            guard let price = coinPrices.display[$0.name] else { return }
                            // Из forEach берем акцию, затем проверяем цену.
                            // Если она не имеет информации о валюте, создаем CoinPriceDisplay с помощью безпараметрического конструктора
                            mintedCouns.append(MintedCoin(coin: $0, price: price["RUB"] ?? CoinPriceDisplay()))
                        }
                        // Вызов замыкания.
                        completion(.Success(mintedCouns))
                    case .Error: print("error get coins")
                    }
                })
            }
            catch let error {
                print(error)
            }
        }
        
    }
}
