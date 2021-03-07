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
        self.timeFrom = try container.decode(UInt.self, forKey: .timeFrom)
        self.timeTo = try container.decode(UInt.self, forKey: .timeTo)
        self.data = try container.decode([CoinPriceForAPeriodCloseInfo].self, forKey: .data)
    }
    
    init() {
        self.timeFrom = 0
        self.timeTo = 0
        self.data = []
    }
}
