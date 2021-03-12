//
//  NewsData.swift
//  TossACoin
//
//  Created by Софья Тимохина on 08.03.2021.
//

import Foundation

// Все новости.
struct NewsData: Codable {
     let news: [Article]
    enum CodingKeys: String, CodingKey {
        case news = "Data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.news = try container.decode([Article].self, forKey: .news)
    }
}
