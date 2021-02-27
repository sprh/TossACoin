//
//  StocksListContainer.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
import UIKit

final class StocksListContainer {
    let input: StocksListModuleInput
    let viewController: UIViewController
    private(set) weak var router: StocksListRouterInput!
    
    class func assemble(with context: StocksListContext) -> StocksListContainer{
        let router = StocksListRouter()
        let interactor = StocksListInteractor()
        let presenter = StocksListPresenter(router: router, interactor: interactor)
        let viewController = StocksListViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        interactor.output = presenter
        router.viewController = viewController
        return StocksListContainer(view: viewController, input: presenter, router: router)
        
    }
    
    private init(view: UIViewController, input: StocksListModuleInput, router: StocksListRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}


struct StocksListContext {
    weak var moduleOutput: StocksListModuleOutput?
}
