//
//  EnviromentProtocol.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

protocol EnviromentProtocol {
    var currency: String { get set }
    var favouriteCoins: [String: Float] { get set }
    func reset()
}

