//
//  Suggestion.swift
//  TossACoin
//
//  Created by Софья Тимохина on 12.03.2021.
//

//{"nodeName":"BTCMoon (BTCM)","pageTitle":"BTCMoon (BTCM) - Live streaming prices and market cap","fullPath":"/coins/btcm/","firstInGroup":"1","__NodeTypeAlias":"webpagecoinp","group":"Coins"}
import Foundation

// Предложения.
struct  Suggestion: Codable {
    let nodeName: String
    
    enum CodingKeys: String, CodingKey {
        case nodeName = "nodeName"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nodeName = try container.decode(String.self, forKey: .nodeName)
    }
}
