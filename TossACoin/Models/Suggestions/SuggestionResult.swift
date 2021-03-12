//
//  SuggestionResult.swift
//  TossACoin
//
//  Created by Софья Тимохина on 12.03.2021.
//

import Foundation

// Результат предложений.
struct SuggestionResult: Codable {
    let suggestions: [Suggestion]
    
    enum CodingKeys: String, CodingKey {
        case suggestions = "Results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.suggestions = try container.decode([Suggestion].self, forKey: .suggestions)
    }
}
