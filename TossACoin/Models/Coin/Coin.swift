//
//  Coin.swift
//  TossACoin
//
//  Created by Софья Тимохина on 28.02.2021.
//

import Foundation

// MARK: - Модель основной информации об акции.
public struct Coin: Codable {
    let id: String
    let name: String
    let fullName: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case imageUrl = "ImageUrl"
        case fullName = "FullName"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
        }
}
