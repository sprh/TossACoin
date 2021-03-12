//
//  CoinPriceDisplay.swift
//  TossACoin
//
//  Created by Софья Тимохина on 06.03.2021.
//

import Foundation
//{"RAW":{"BT":...,"DISPLAY":{"BT":{"RUB":{"FROMSYMBOL":"BT","TOSYMBOL":"₽","MARKET":"Bibox","PRICE":"₽ 2,798.08","LASTUPDATE":"Just now","LASTVOLUME":"BT 0.01000","LASTVOLUMETO":"₽ 27.98","LASTTRADEID":"16150475450001","VOLUMEDAY":"BT 2,123.93","VOLUMEDAYTO":"₽ 5,942,932.6","VOLUME24HOUR":"BT 2,989.69","VOLUME24HOURTO":"₽ 8,365,396.5","OPENDAY":"₽ 2,684.23","HIGHDAY":"₽ 2,847.11","LOWDAY":"₽ 2,635.57","OPEN24HOUR":"₽ 2,560.97","HIGH24HOUR":"₽ 2,851.55","LOW24HOUR":"₽ 2,554.87","VOLUMEHOUR":"BT 22.70","VOLUMEHOURTO":"₽ 63,516.4","OPENHOUR":"₽ 2,747.58","HIGHHOUR":"₽ 2,798.91","LOWHOUR":"₽ 2,739.26","CHANGE24HOUR":"₽ 237.11","CHANGEPCT24HOUR":"9.26","CHANGEDAY":"₽ 113.85","CHANGEPCTDAY":"4.24","CHANGEHOUR":"₽ 50.49","CHANGEPCTHOUR":"1.84","CONVERSIONTYPE":"multiply","CONVERSIONSYMBOL":"ETH","SUPPLY":"BT 91,125.0","MKTCAP":"₽ 254.97 M","MKTCAPPENALTY":"0 %","TOTALVOLUME24H":"BT 0","TOTALVOLUME24HTO":"₽ 0","TOTALTOPTIERVOLUME24H":"BT 0","TOTALTOPTIERVOLUME24HTO":"₽ 0","IMAGEURL":"/media/37746024/bt.png"}}}}
// MARK: - Дисплей из вызова цены акции.
// Выше пример вызова.
struct CoinPriceDisplay: Decodable{
    let price: String
    let changePercent: String
//    let marketCap: String
//    let supply: String
//    let volume24H: String
//    let volume24HTO: String
//    let totalVolume24H: String
//    let totalVolume24HTO: String
//    let priceOpen24Hour: String
//    let priceHigh24Hour: String
//    let priceLow24Hour: String
    
    // TODO:  Удалить лишнее.
    private enum CodingKeys: String, CodingKey {
        case price = "PRICE"
        case changePercent = "CHANGEPCT24HOUR"
//        case marketCap = "MKTCAP"
//        case supply = "SUPPLY"
//        case volume24H = "VOLUME24HOUR"
//        case volume24HTO = "VOLUME24HOURTO"
//        case totalVolume24H = "TOTALVOLUME24H"
//        case totalVolume24HTO = "TOTALVOLUME24HTO"
//        case priceOpen24Hour = "OPEN24HOUR"
//        case priceHigh24Hour = "HIGH24HOUR"
//        case priceLow24Hour = "LOW24HOUR"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.price = try container.decodeIfPresent(String.self, forKey: .price) ?? "0"
        self.changePercent = try container.decodeIfPresent(String.self, forKey: .changePercent) ?? "0"
    }
    
    init() {
        self.price = ""
        self.changePercent = ""
//        self.marketCap = ""
//        self.supply = ""
//        self.volume24H = ""
//        self.volume24HTO = ""
//        self.totalVolume24H = ""
//        self.totalVolume24HTO = ""
//        self.priceLow24Hour = ""
//        self.priceOpen24Hour = ""
//        self.priceHigh24Hour = ""
    }
}
