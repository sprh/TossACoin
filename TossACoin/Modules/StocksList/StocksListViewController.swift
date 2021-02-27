//
//  StocksListViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
import UIKit


final class StocksListViewController: UIViewController {
    var moduleOutput: StocksListViewOutput?
    
    init(output: StocksListViewOutput) {
        self.moduleOutput = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        self.view = view
    }
}

extension StocksListViewController: StocksListViewInput {
    
}
