//
//  Suggestion.swift
//  TossACoin
//
//  Created by Софья Тимохина on 12.03.2021.
//

//{"nodeName":"BTCMoon (BTCM)","pageTitle":"BTCMoon (BTCM) - Live streaming prices and market cap","fullPath":"/coins/btcm/","firstInGroup":"1","__NodeTypeAlias":"webpagecoinp","group":"Coins"}
import Foundation

// Предложения.
// {"Id":"4581","Symbol":"NYAN","Name":"NyanCoin (NYAN)","ImageUrl":"/media/19842/nyan.png","BaseUrl":"/coins/nyan/"}
struct  Suggestion: Codable {
    let id: String
    let symbol: String
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case symbol = "Symbol"
        case name = "Name"
        case imageUrl = "ImageUrl"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
    }
}
