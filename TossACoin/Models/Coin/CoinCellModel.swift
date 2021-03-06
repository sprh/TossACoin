//
//  CoinCellModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 28.02.2021.
//

import Foundation
import UIKit

// MARK: - Модель для CoinsCollectionView.
public struct CoinCellModel {
    let id: String
    let name: String
    let fullName: String
    let imageUrl: String
    let price: String
    let changePercent: String
    
    
    init(coin: Coin, priceDisplay: CoinPriceDisplay) {
        self.id = coin.id
        self.name = coin.name
        self.fullName = coin.fullName
        self.imageUrl = coin.imageUrl
        self.price = priceDisplay.price
        self.changePercent = priceDisplay.changePercent
    }
}
