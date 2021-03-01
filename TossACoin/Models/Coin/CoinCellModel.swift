//
//  CoinCellModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 28.02.2021.
//

import Foundation
import UIKit

public struct CoinCellModel {
    let id: String
    let regularMarketChangePercent: Float
    let companyName: String
    let name: String
    let price: Float
    let financialCurrency: String
    
    init(coin: Coin) {
        self.id = coin.id
        self.regularMarketChangePercent = coin.regularMarketChangePercent
        self.companyName = coin.companyName
        self.name = coin.name
        self.price = coin.price
        self.financialCurrency = coin.financialCurrency
    }
}
