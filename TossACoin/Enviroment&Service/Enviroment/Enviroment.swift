//
//  Enviroment.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

class Enviroment: EnviromentProtocol {
    private let dataStorage: DataStorage = DataStorage()
    
    public func reset() {
        dataStorage.removeValue(forKey: DataStorageKeys.currency)
        dataStorage.removeValue(forKey: DataStorageKeys.favouriteCoins)
    }
    
//    var currency: String {
//        get {
//            return dataStorage.getValue(forKey: DataStorageKeys.currency)
//        }
//        set {
//            dataStorage.setValue(value: newValue, forKey: DataStorageKeys.currency)
//        }
//    }
    
    var favouriteCoins: [String: Float] {
        get {
            return dataStorage.getValue(forKey: DataStorageKeys.favouriteCoins)
        }
        set {
            dataStorage.setValue(value: newValue, forKey: DataStorageKeys.favouriteCoins)
        }
    }
    
}
