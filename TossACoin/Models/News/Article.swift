//
//  Article.swift
//  TossACoin
//
//  Created by Софья Тимохина on 08.03.2021.
//

import Foundation

// Только 1 новость.
struct Article: Codable {
    let title: String
    let imageUrl: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case imageUrl = "imageurl"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
        self.url = try container.decode(String.self, forKey: .url)
    }
}
