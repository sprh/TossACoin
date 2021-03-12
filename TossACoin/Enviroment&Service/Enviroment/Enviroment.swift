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
//    private let dataStorage: DataStorage = DataStorage()
    
    // Сброс хранилища.
    public func reset() {
        
    }
    
    // Акции в избранном.
    var favouriteCoins: [Coin] {
        get {
            if let objects = UserDefaults.standard.value(forKey: "favouriteCoins") as? Data {
               let decoder = JSONDecoder()
               if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Coin] {
                  return objectsDecoded
               } else {
                  return []
               }
            } else {
               return []
            }
        }
        set (newValue) {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue){
               UserDefaults.standard.set(encoded, forKey: "favouriteCoins")
            }
            // dataStorage.setValue(value: newValue, forKey: DataStorageKeys.favouriteCoins)
        }
    }
    
}
