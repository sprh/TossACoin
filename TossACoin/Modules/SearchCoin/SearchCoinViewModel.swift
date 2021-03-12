//
//  SearchCoinViewModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation
import UIKit

class SearchCoinViewModel {
    fileprivate var enviroment: Enviroment
    fileprivate var networkService: NetworkService
    
    init(enviroment: Enviroment, networkService: NetworkService) {
        self.enviroment = enviroment
        self.networkService = networkService
    }
    
    func getSuggestions(symbol: String, completion: @escaping () -> Void) {
        networkService.getSuggestions(symbol: symbol) { (result) in
            switch result {
            case .Success(let suggestions):
                print(suggestions)
            case .Error:
                print("Error")
            }
        }
    }
}
