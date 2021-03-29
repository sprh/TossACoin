//
//  Suggestion.swift
//  TossACoin
//
//  Created by Софья Тимохина on 12.03.2021.
//

import Foundation

// Предложения.
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
        var name = try container.decode(String.self, forKey: .name)
        let regex = try! NSRegularExpression(pattern: "\\(.*\\)", options: [])
        name = regex.stringByReplacingMatches(in: name, options: [], range: NSRange(0..<name.utf16.count), withTemplate: "")
        self.name = name
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
    }
}
