//
//  CoinListFavouriteCoinsViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation
import UIKit
import XLPagerTabStrip

class CoinListFavouriteCoinsViewController: UIViewController, IndicatorInfoProvider {
    fileprivate let viewModel: FavouriteCoinsViewModel!

    init(viewModel: FavouriteCoinsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(image: UIImage(systemName: "star"), highlightedImage: UIImage(systemName: "star"), userInfo: nil)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        view.backgroundColor = .green
        self.view = view
    }
}
