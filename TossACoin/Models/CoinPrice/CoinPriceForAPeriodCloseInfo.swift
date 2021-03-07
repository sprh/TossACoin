//
//  CoinPriceForAPeriodCloseInfo.swift
//  TossACoin
//
//  Created by Софья Тимохина on 07.03.2021.
//

import Foundation

struct CoinPriceForAPeriodCloseInfo: Codable {
    let time: UInt
    let close: Double
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case close = "close"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.time = try container.decode(UInt.self, forKey: .time)
        self.close = try container.decode(Double.self, forKey: .close)
    }
}
