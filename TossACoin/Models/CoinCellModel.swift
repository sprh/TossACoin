//
//  CoinCellModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 28.02.2021.
//

import Foundation
import UIKit

public struct CoinCellModel {
    let exchangeDataDelayedBy: Float
    let companyName: String
    let financialCurrency: String
    let symbol: String
    let name: String
    
    init(coin: Coin) {
        self.exchangeDataDelayedBy = coin.exchangeDataDelayedBy
        self.companyName = coin.companyName
        self.financialCurrency = coin.financialCurrency
        self.symbol = coin.symbol
        self.name = coin.name
    }
}
