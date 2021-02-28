//
//  DataStorage.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
public class DataStorage: DataStorageProtocol {
    public var userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    public func setValue<T>(value: T, forKey key: DataStorageKey<T>) {
        userDefaults.setValue(value, forKey: key.key)
    }
    
    public func getValue<T>(forKey key: DataStorageKey<T>) -> T {
        return userDefaults.object(forKey: key.key) as? T ?? key.defaultValue
    }
    
    public func removeValue<T>(forKey key: DataStorageKey<T>) {
        userDefaults.removeObject(forKey: key.key)
    }
    
    
}
