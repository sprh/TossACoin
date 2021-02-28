//
//  DataStorage.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
public class DataStorage: DataStorageProtocol {
    public func setValue<T>(value: T, for key: DataStorageKey<T>) {
        
    }
    
    public func getValue<T>(forKey key: DataStorageKey<T>) -> T {
        return T.self as! T
    }
    
    public func removeValue<T>(for key: DataStorageKey<T>) {
        
    }
    
    
}
