//
//  DateExtension.swift
//  TossACoin
//
//  Created by Софья Тимохина on 15.03.2021.
//

import Foundation

extension Date {
    // MARK: - Создание даты из unix формата. Будет видно только время.
    static func getDateFormUnixForMinuteAndHour(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    // MARK: - Создание даты из unix форматаЮ Будет видно только дату.
    static func getDateFormUnixForDaily(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
