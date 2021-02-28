//
//  APIClient.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

public struct APIClient {
    static let apiUrl: String =  "https://mboum.com/api/v1"

    static func getCoins(page: Int = 1) -> String {
        return "\(apiUrl)/co/collections/?list=undervalued_growth_stocks&start=\(page)&apikey=demo"
    }
    
    static func getQuotes(symbol: String) -> String {
        return "\(apiUrl)/qu/quote/?symbol=\(symbol),F&apikey=demo"
    }
}
