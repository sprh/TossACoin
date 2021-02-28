//
//  NetworkServiceProtocol.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
protocol NetworkServiceProtocol {
    func getCoins(page: Int, completion: @escaping (NetworkServiceResult<[Coin]>) -> Void)
    func getCoin(symbols: [String], completion: @escaping (NetworkServiceResult<[Coin]>) -> Void)
}
