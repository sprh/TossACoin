//
//  CoinsContainerViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 12.03.2021.
//

import Foundation
import UIKit
import XLPagerTabStrip

class CoinsContainerViewController: ButtonBarPagerTabStripViewController {
    var viewModel: CoinsContainerViewModel!
    
    init(viewModel: CoinsContainerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Вот это чинит проблему скролла на дочерних экранах.
    override public var scrollPercentage: CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        containerView.contentOffset.y = -(window?.safeAreaInsets.top ?? 0)
        return super.scrollPercentage
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .backgroundColor
        setSettings()
        super.viewDidLoad()
        setupNavigationController()
    }
    
    // Настройка ButtonBarView.
    private func setSettings() {
        containerView?.isScrollEnabled = true
        settings.style.buttonBarBackgroundColor = .backgroundColor
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = .orangeColor
        settings.style.selectedBarHeight = 4.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            newCell?.label.textColor = .orangeColor
            oldCell?.label.textColor = .gray
            oldCell?.label.font = .boldSystemFont(ofSize: 20)
            newCell?.label.font = .boldSystemFont(ofSize: 27)
        }
    }
    
    func setupNavigationController() {
        // MARK: - Настройки для navigationBar.
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .backgroundColor
        navigationController?.navigationBar.barTintColor = .backgroundColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.addSubview(buttonBarView!)
    }
    
    // MARK: - Все дочерние экраны.
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let allCoinsViewController =  viewModel.getAllCoinsViewController()
        let favouriteCoinsViewController =  viewModel.getFavouriteCoinsViewController()
        return [allCoinsViewController, favouriteCoinsViewController]
    }
}
