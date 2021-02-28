//
//  APIClient.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

public struct APIClient {
    static let apiUrl: String =  "https://mboum.com/api/v1"
    static let baseUrl: String = "https://cryptocompare.com"

    static func getCoins(page: Int = 1) -> String {
        return "\(apiUrl)/co/collections/?list=day_gainers&start=\(page)&apikey=demo"
    }
    
    static func getCoin(symbols: String, currency: String) -> String {
        return "\(apiUrl)/data/coin/generalinfo?fsyms=\(symbols)&tsym=\(currency)"
    }
}
