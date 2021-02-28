//
//  DataStorageKeys.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
public struct DataStorageKeys {
    static let currency = DataStorageKey(key: "Currency", dataStorageOptions: DataStorageOptions.defaults, valueType: String.self, defaultValue: "RUB")
    static let favouriteStocks = DataStorageKey(key: "FavouriteStocks", dataStorageOptions: DataStorageOptions.defaults, valueType: String.self, defaultValue: "")
}
