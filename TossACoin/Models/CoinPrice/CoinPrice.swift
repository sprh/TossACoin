//
//  CoinPrice.swift
//  TossACoin
//
//  Created by Софья Тимохина on 06.03.2021.
//

import Foundation

// MARK: - Модель цены только с Дисплеем.
struct CoinPrice: Decodable {
    let display: [String: [String: CoinPriceDisplay]]
    
    enum CodingKeys: String, CodingKey {
        case display = "DISPLAY"
    }
}
