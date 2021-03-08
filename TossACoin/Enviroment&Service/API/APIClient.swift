//
//  APIClient.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

// MARK: - API.
public struct APIClient {
    // Дефолтный адрес.
    static let apiUrl: String =  "https://min-api.cryptocompare.com"

    // Url -> получение (всех) акций на странице.
    static func getCoins(page: Int = 1) -> String {
        // Можно добавить выбор валюты.
        return "\(apiUrl)/data/top/totalvol?limit=15&page=\(page)&tsym=RUB"
    }
    
    // Url -> получение цен.
    static func getPrices(symbols: String) -> String {
        return "\(apiUrl)/data/pricemultifull?fsyms=\(symbols)&tsyms=RUB"
    }
    
    static func getQuote(symbols: String) -> String {
        return "https://mboum.com/api/v1/qu/quote/?symbol=\(symbols),F&apikey=demo"
    }
    
    // Url -> получение изображения.
    static func getImageUrl(imageUrl: String) -> String{
        return "https://cryptocompare.com/\(imageUrl)"
    }
    
    static func getDailyPair(symbol: String) ->String {
        return "\(apiUrl)/data/v2/histoday?fsym=\(symbol)&tsym=RUB&limit=15"
    }
//    static func getQuotes(symbol: String) -> String {
//        return "\(apiUrl)/qu/quote/?symbol=\(symbol),F&apikey=demo"
//    }
    
    static func getBuyCoin(symbol: String) -> String {
        return "https://yandex.ru/search/?text=buy%20\(symbol)&lr=0"
    }
}
