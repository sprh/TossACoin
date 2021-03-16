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

    // Url -> получение (всех) акций на странице.
    static func getCoins(page: Int = 1) -> String {
        // Можно добавить выбор валюты.
        return "\(apiUrlForCoins)/data/top/totalvol?limit=15&page=\(page)&tsym=USD"
    }
    
    // Url -> получение цен.
    static func getPrices(symbols: String) -> String {
        return "\(apiUrlForCoins)/data/pricemultifull?fsyms=\(symbols)&tsyms=USD"
    }
    
    // Url -> получение изображения.
    static func getImageUrl(imageUrl: String) -> String{
        return "https://cryptocompare.com/\(imageUrl)"
    }
    
    // Информация о цене акции по дням.
    static func getDailyPair(symbol: String) ->String {
        return "\(apiUrlForCoins)/data/v2/histoday?fsym=\(symbol)&tsym=USD&limit=20"
    }
    
    // Открытие страницы в яндексе.
    static func getBuyCoin(symbol: String) -> String {
        return "https://yandex.ru/search/?text=buy%20\(symbol)&lr=0"
    }
    
    // Информация о цене акции по часам.
    static func getHourlyPair(symbol: String) -> String {
        return "\(apiUrlForCoins)/data/v2/histohour?fsym=\(symbol)&tsym=USD&limit=20"
    }
    
    // Информация о цене акции по минутам.
    static func getMinutePair(symbol: String) -> String {
        return "\(apiUrlForCoins)/data/v2/histominute?fsym=\(symbol)&tsym=USD&limit=20"
    }
    
    // Получение новостей.
    static func getNews(symbol: String) -> String {
        return "\(apiUrlForCoins)/data/v2/news/?categories=\(symbol)"
    }
    
    // Предложения поиска.
    static func getSuggestions(symbol: String) -> String {
        return "https://www.cryptocompare.com/api/autosuggest/coins/?maxRows=15&q=\(symbol)"
    }
    
    static func grtPopularRequests() -> String {
        return "https://www.cryptocompare.com/api/autosuggest/coins"
    }
}
