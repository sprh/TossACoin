//
//  Coin.swift
//  TossACoin
//
//  Created by Софья Тимохина on 28.02.2021.
//

import Foundation

struct Coin: Codable {
    let regularMarketChangePercent: Float
    let priceHint: Float
    let exchangeDataDelayedBy: Float
    let companyName: String
    let financialCurrency: String
    let symbol: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case regularMarketChangePercent = "regularMarketChangePercent"
        case priceHint = "priceHint"
        case exchangeDataDelayedBy = "exchangeDataDelayedBy"
        // I'm not sure.
        case companyName = "shortName"
        case financialCurrency = "financialCurrency"
        case symbol = "symbol"
        case name = "fullExchangeName"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.regularMarketChangePercent = try container.decode(Float.self, forKey: CodingKeys.regularMarketChangePercent)
        self.priceHint = try container.decode(Float.self, forKey: CodingKeys.priceHint)
        self.exchangeDataDelayedBy = try container.decode(Float.self, forKey: CodingKeys.exchangeDataDelayedBy)
        self.companyName = try container.decode(String.self, forKey: CodingKeys.companyName)
        self.financialCurrency = try container.decode(String.self, forKey: CodingKeys.financialCurrency)
        // TODO make url to the image.
        self.symbol = try container.decode(String.self, forKey: CodingKeys.symbol)
        self.name = try container.decode(String.self, forKey: CodingKeys.name)
        }
}
