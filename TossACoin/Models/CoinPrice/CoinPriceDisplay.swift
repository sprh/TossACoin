//
//  CoinPriceDisplay.swift
//  TossACoin
//
//  Created by Софья Тимохина on 06.03.2021.
//

import Foundation

// MARK: - Дисплей из вызова цены акции.
struct CoinPriceDisplay: Decodable{
    let price: String
    let changePercent: String
    private enum CodingKeys: String, CodingKey {
        case price = "PRICE"
        case changePercent = "CHANGEPCT24HOUR"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.price = try container.decodeIfPresent(String.self, forKey: .price) ?? "0"
        self.changePercent = try container.decodeIfPresent(String.self, forKey: .changePercent) ?? "0"
    }
    
    init() {
        self.price = ""
        self.changePercent = ""
    }
}
