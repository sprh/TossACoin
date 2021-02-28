//
//  DataStorageProtocol.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

public protocol DataStorageProtocol {
    // MARK: The user's default db.
    var userDefaults: UserDefaults {get}
    // MARK: Add the value to db.
    func setValue<T>(value: T, forKey key: DataStorageKey<T>)
    // MARK: Get the value from db.
    func getValue<T>(forKey key: DataStorageKey<T>) -> T
    // MARK: Remove the value from db.
    func removeValue<T>(forKey key: DataStorageKey<T>)
}
