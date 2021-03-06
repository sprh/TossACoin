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
    
    // Url -> получение изображения.
    static func getImageUrl(imageUrl: String) -> String{
        return "https://cryptocompare.com/\(imageUrl)"
    }
    
//    static func getQuotes(symbol: String) -> String {
//        return "\(apiUrl)/qu/quote/?symbol=\(symbol),F&apikey=demo"
//    }
}
