//
//  CoinData.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation

// MARK: - Информация об акции из вызова getCoins.
public struct CoinData: Codable {
    let coin: Coin
    
    enum CodingKeys: String, CodingKey {
        case coin = "CoinInfo"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.coin = try container.decode(Coin.self, forKey: .coin)
    }
}
