//
//  EnviromentProtocol.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

// MARK: - Протокол среды приложения.
protocol EnviromentProtocol {
    var favouriteCoins: [Coin] { get set }
    func reset()
}

