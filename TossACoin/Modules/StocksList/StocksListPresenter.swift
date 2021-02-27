//
//  StocksListPresenter.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

final class StocksListPresenter {
    weak var view: StocksListViewInput?
    weak var moduleOutput: StocksListModuleOutput?
    private let router: StocksListRouterInput
    private let interactor: StocksListInteractorInput
    
    init(router: StocksListRouterInput, interactor: StocksListInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension StocksListPresenter: StocksListModuleInput {
}

extension StocksListPresenter: StocksListViewOutput {
}

extension StocksListPresenter: StocksListInteractorOutput {
    
}


