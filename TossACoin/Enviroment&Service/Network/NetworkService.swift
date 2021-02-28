//
//  NetworkService.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
import Alamofire

public struct NetworkService: NetworkServiceProtocol {
    private let decoder = JSONDecoder()
    
    
    func getCoins(page: Int, completion: @escaping (NetworkServiceResult<[Coin]>) -> Void) {
        guard let url = URL(string: APIClient.getCoins(page: page)) else {
            print("Get coins url error")
            return
        }

        AF.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print(error)
            }
            
            guard let data = dataResponse.data else {
                print("no data")
                return
            }

            do {
                let result = try self.decoder.decode(Result.self, from: data)
                print(result.data)
            }
            catch let decodeError {
                print("\(decodeError)")
            }
        }
        
    }
    
    func getCoin(symbols: [String], completion: @escaping (NetworkServiceResult<[Coin]>) -> Void)  {
    }
}
