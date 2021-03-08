//
//  CoinPriceForAPeriodData.swift
//  TossACoin
//
//  Created by Софья Тимохина on 07.03.2021.
//

import Foundation

struct CoinPriceForAPeriodData: Codable {
    let timeFrom: UInt
    let timeTo: UInt
    let data: [CoinPriceForAPeriodCloseInfo]
    
    enum CodingKeys: String, CodingKey {
        case timeFrom = "TimeFrom"
        case timeTo = "TimeTo"
        case data = "Data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timeFrom = try container.decodeIfPresent(UInt.self, forKey: .timeFrom) ?? 0
        self.timeTo = try container.decodeIfPresent(UInt.self, forKey: .timeTo) ?? 0
        self.data = try container.decode([CoinPriceForAPeriodCloseInfo].self, forKey: .data)
    }
    
    init() {
        self.timeFrom = 0
        self.timeTo = 0
        self.data = []
    }
}
