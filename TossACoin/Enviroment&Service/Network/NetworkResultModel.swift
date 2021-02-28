//
//  NetworkResultModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 28.02.2021.
//

import Foundation

struct Result: Codable {
    let data: [Coin]
    
    enum CodingKeys: String, CodingKey {
        case data = "quotes"
    }
}
