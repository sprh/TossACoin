//
//  CoinInfoViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation
import UIKit

class CoinInfoViewController: UIViewController {
    var viewModel: CoinInfoViewModel!
    
    init(viewModel: CoinInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(popViewController))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
