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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        setSettings()
    }
    
    // Настройка экрана.
    private func setSettings() {
        // MARK: - Настройки для buttonBarView.
        containerView?.isScrollEnabled = true
        settings.style.buttonBarBackgroundColor = UIColor(named: "backgroundColor")
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = .orangeColor
        settings.style.selectedBarHeight = 3.0
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
        
        // MARK: - Настройки для navigationBar.
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.sizeToFit()
        navigationController?.navigationBar.addSubview(buttonBarView!)
        super.viewDidLoad()
    }
    
    // MARK: - Все дочерние экраны.
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let allCoinsViewController =  viewModel.getAllCoinsViewController()
        let favouriteCoinsViewController =  viewModel.getFavouriteCoinsViewController()
        return [allCoinsViewController, favouriteCoinsViewController]
    }
}
