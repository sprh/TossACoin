//
//  DataStorageProtocol.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

public protocol DataStorageProtocol {
    func setValue<T>(value: T, for key: DataStorageKey<T>)
    func getValue<T>(forKey key: DataStorageKey<T>) -> T
    func removeValue<T>(for key: DataStorageKey<T>)
}
