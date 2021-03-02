//
//  CoinsScreensContainerViewModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation

class CoinsScreensContainerViewModel {
    private let enviroment: Enviroment
    private let networkService: NetworkService
    
    init(enviroment: Enviroment, networkService: NetworkService) {
        self.enviroment = enviroment
        self.networkService = networkService
    }
}
