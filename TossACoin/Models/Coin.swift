//
//  Coin.swift
//  TossACoin
//
//  Created by Софья Тимохина on 28.02.2021.
//

import Foundation

struct Coin: Codable {
    let id: String
    let regularMarketChangePercent: Float
    let priceHint: Float
    let exchangeDataDelayedBy: Float
    let companyName: String
    let financialCurrency: String
    let name: String
    let price: Float
    
    enum CodingKeys: String, CodingKey {
        case id = "messageBoardId"
        case regularMarketChangePercent = "regularMarketChangePercent"
        case priceHint = "priceHint"
        case exchangeDataDelayedBy = "exchangeDataDelayedBy"
        // I'm not sure.
        case companyName = "shortName"
        case financialCurrency = "financialCurrency"
        // I'm not sure.
        case name = "symbol"
        case price = "regularMarketPrice"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.regularMarketChangePercent = try container.decode(Float.self, forKey: CodingKeys.regularMarketChangePercent)
        self.priceHint = try container.decode(Float.self, forKey: CodingKeys.priceHint)
        self.exchangeDataDelayedBy = try container.decode(Float.self, forKey: CodingKeys.exchangeDataDelayedBy)
        self.companyName = try container.decode(String.self, forKey: CodingKeys.companyName)
        self.financialCurrency = try container.decode(String.self, forKey: CodingKeys.financialCurrency)
//        self.symbol = try container.decode(String.self, forKey: CodingKeys.symbol)
        self.name = try container.decode(String.self, forKey: CodingKeys.name)
        self.id = try container.decode(String.self, forKey: CodingKeys.id)
        self.price = try container.decode(Float.self, forKey: CodingKeys.price)
        }
}
