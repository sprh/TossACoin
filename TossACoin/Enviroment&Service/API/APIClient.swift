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
    static let apiUrlForCoins: String =  "https://min-api.cryptocompare.com"
    static let apiUrlForNews: String = "https://newsapi.org"

    // Url -> получение (всех) акций на странице.
    static func getCoins(page: Int = 1) -> String {
        // Можно добавить выбор валюты.
        return "\(apiUrlForCoins)/data/top/totalvol?limit=15&page=\(page)&tsym=RUB"
    }
    
    // Url -> получение цен.
    static func getPrices(symbols: String) -> String {
        return "\(apiUrlForCoins)/data/pricemultifull?fsyms=\(symbols)&tsyms=RUB"
    }
    
    static func getQuote(symbols: String) -> String {
        return "https://mboum.com/api/v1/qu/quote/?symbol=\(symbols),F&apikey=demo"
    }
    
    // Url -> получение изображения.
    static func getImageUrl(imageUrl: String) -> String{
        return "https://cryptocompare.com/\(imageUrl)"
    }
    
    static func getDailyPair(symbol: String) ->String {
        return "\(apiUrlForCoins)/data/v2/histoday?fsym=\(symbol)&tsym=RUB&limit=15"
    }
//    static func getQuotes(symbol: String) -> String {
//        return "\(apiUrlForCoins)/qu/quote/?symbol=\(symbol),F&apikey=demo"
//    }
    
    static func getBuyCoin(symbol: String) -> String {
        return "https://yandex.ru/search/?text=buy%20\(symbol)&lr=0"
    }
    
    static func getHourlyPair(symbol: String) -> String {
        return "\(apiUrlForCoins)/data/v2/histohour?fsym=\(symbol)&tsym=RUB&limit=15"
    }
    
    static func getMinutePair(symbol: String) -> String {
        return "\(apiUrlForCoins)/data/v2/histominute?fsym=\(symbol)&tsym=RUB&limit=15"
    }
    
    static func getNews(symbol: String, page: Int) -> String {
        return "\(apiUrlForNews)/v2/everything?q=\(symbol)&language=en&pageSize=10&page=\(page)&apiKey=a330532395e14e728a7b8fc3b3e0f8ee"
    }
}
