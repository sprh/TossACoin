//
//  StocksListProtocols.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

protocol StocksListModuleInput {
    var moduleOutput: StocksListModuleOutput? {get}
}

protocol StocksListModuleOutput: class {
}

protocol StocksListViewInput: class {
}

protocol StocksListViewOutput: class {
}

protocol StocksListInteractorInput: class {
}

protocol StocksListInteractorOutput: class {
}

protocol StocksListRouterInput: class {
}
