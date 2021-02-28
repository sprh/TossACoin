//
//  DataStorageKeys.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
public struct DataStorageKeys {
    // MARK: Local currency.
    static let currency = DataStorageKey(key: "Currency", dataStorageOptions: DataStorageOptions.userDefaults, valueType: String.self, defaultValue: "RUB")
    
    // MARK: Users favourite coins.
    static let favouriteCoins = DataStorageKey(key: "FavouriteCoins", dataStorageOptions: DataStorageOptions.userDefaults, valueType: [String: Float].self, defaultValue: [:])
}
