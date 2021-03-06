//
//  DataStorageKey.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

// MARK: - Ключи для хранилища.
public struct DataStorageKey<T> {
    public let key: String
    public let dataStorageOptions: DataStorageOptions
    public let defaultValue: T
    
    public init(key: String, dataStorageOptions: DataStorageOptions, valueType: T.Type, defaultValue: T) {
        self.key = key
        self.dataStorageOptions = dataStorageOptions
        self.defaultValue = defaultValue
    }
}
