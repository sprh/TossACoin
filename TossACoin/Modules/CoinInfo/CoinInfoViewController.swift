//
//  CoinInfoViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation
import UIKit
import XLPagerTabStrip

class CoinInfoViewController: ButtonBarPagerTabStripViewController {
    var viewModel: CoinInfoViewModel!
    lazy var scrollView = UIScrollView()
      lazy var barView: ButtonBarView = {
        let layout = UICollectionViewFlowLayout()
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 64)
        let collectionView = ButtonBarView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        return collectionView
      }()
    
    init(viewModel: CoinInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
      
//        override func viewDidLoad() {
//        view.addSubview(scrollView)
//        containerView = scrollView
//        view.addSubview(barView)
//        buttonBarView = barView
//        super.viewDidLoad()
//      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = .orange
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = .orange
        }

        containerView?.isScrollEnabled = true
        super.viewDidLoad()
        definesPresentationContext = true
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let mainViewController = MainInfoViewController()
        let newsViewController = NewsViewController()
        return [mainViewController, newsViewController]
    }
}
