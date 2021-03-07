//
//  ResultCoins.swift
//  TossACoin
//
//  Created by Софья Тимохина on 28.02.2021.
//

import Foundation

// Результат подключения для получения информации об акциях.
struct ResultCoins: Codable {
    let message: String
    let data: [CoinData]
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case data = "Data"
    }
}
