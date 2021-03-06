//
//  DataStorage.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

// MARK: - Хранилище данных.

public class DataStorage: DataStorageProtocol {
    public var userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    // Добавление.
    public func setValue<T>(value: T, forKey key: DataStorageKey<T>) {
        userDefaults.setValue(value, forKey: key.key)
    }
    
    // Получение.
    public func getValue<T>(forKey key: DataStorageKey<T>) -> T {
        return userDefaults.object(forKey: key.key) as? T ?? key.defaultValue
    }
    
    // Удаление.
    public func removeValue<T>(forKey key: DataStorageKey<T>) {
        userDefaults.removeObject(forKey: key.key)
    }
    
    
}
