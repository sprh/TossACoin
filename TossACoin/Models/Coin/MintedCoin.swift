//
//  MintedCoin.swift
//  TossACoin
//
//  Created by Софья Тимохина on 06.03.2021.
//

import Foundation

// MARK: - Модель акции с основной частью и ценой.
struct MintedCoin {
    let coin: Coin
    let price: CoinPriceDisplay
    
    public init(coin: Coin, price: CoinPriceDisplay) {
        self.coin = coin
        self.price = price
    }
}
