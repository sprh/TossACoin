//
//  NewsData.swift
//  TossACoin
//
//  Created by Софья Тимохина on 08.03.2021.
//

import Foundation

struct NewsData: Codable {
    let status: String
     let news: [Article]
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case news = "articles"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.news = try container.decode([Article].self, forKey: .news)
        self.status = try container.decode(String.self, forKey: .status)
    }
}
