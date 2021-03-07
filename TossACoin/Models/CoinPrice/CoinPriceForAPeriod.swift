//
//  CoinPriceForAPeriod.swift
//  TossACoin
//
//  Created by Софья Тимохина on 07.03.2021.
//

import Foundation

struct CoinPriceForAPeriod: Codable {
    let result: String
    let data: CoinPriceForAPeriodData
    
    enum CodingKeys: String, CodingKey {
        case result = "Response"
        case data = "Data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.result = try container.decode(String.self, forKey: .result)
        self.data = try container.decode(CoinPriceForAPeriodData.self, forKey: .data)
    }
    
    init() {
        self.result = ""
        self.data = CoinPriceForAPeriodData()
    }
}
