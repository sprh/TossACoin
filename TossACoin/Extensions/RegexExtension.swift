//
//  RegexExtension.swift
//  TossACoin
//
//  Created by Софья Тимохина on 12.03.2021.
//

import Foundation

extension NSRegularExpression {
    static func regexMatches(pattern: String, text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = text as NSString
            let results = regex.matches(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch {
            return []
        }
    }
}
