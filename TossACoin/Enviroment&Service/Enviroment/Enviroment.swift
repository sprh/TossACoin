//
//  Enviroment.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

// MARK: - Среда.
class Enviroment: EnviromentProtocol {
    // Хранилище.
    private let dataStorage: DataStorage = DataStorage()
    
    // Сброс хранилища.
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
    
    // Акции в избранном.
    var favouriteCoins: [String] {
        get {
            return dataStorage.getValue(forKey: DataStorageKeys.favouriteCoins)
        }
        set (newValue) {
            print(newValue)
            dataStorage.setValue(value: newValue, forKey: DataStorageKeys.favouriteCoins)
        }
    }
    
}
