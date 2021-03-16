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
    fileprivate var headerView = UIView()
    fileprivate let viewName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 35)
        return label
    }()
    
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
        view.backgroundColor = .white
        setupView()
        setSettings()
    }
    
    
    // Настройка вью.
    private func setupView() {
        self.view.backgroundColor = .white
        view.addSubview(headerView)
        // Изменяем конструкции.
        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.bounds.width,
            height: 100.0)

        buttonBarView.frame = CGRect(
            x: 0,
            y: 100,
            width: self.view.bounds.width * 2/3,
            height: 50.0)

        containerView.frame = CGRect(
            x: 0,
            y: 100 + buttonBarView.frame.height,
            width: self.view.bounds.width,
            height: self.view.bounds.height - (100 + buttonBarView.frame.height))
        containerView.largeContentTitle = "AAA"
//        // Настройка header view.
        setupHeaderView()
    }
    
    private func setupHeaderView() {
        headerView.addSubview(viewName)
        [
            viewName.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: view.safeAreaInsets.top + 20),
            viewName.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20)
        ].forEach({$0.isActive = true})
        viewName.text = "Coins"
    }
    
    // Настройка ButtonBarView.
    private func setSettings() {
        containerView?.isScrollEnabled = true
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = ApplicationColors.orangeColor
        settings.style.selectedBarHeight = 4.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            newCell?.label.textColor = ApplicationColors.orangeColor
            oldCell?.label.textColor = .gray
            oldCell?.label.font = .boldSystemFont(ofSize: 20)
            newCell?.label.font = .boldSystemFont(ofSize: 33)
        }
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    // Все дочерние экраны.
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let allCoinsViewController =  viewModel.getAllCoinsViewController()
        let favouriteCoinsViewController =  viewModel.getFavouriteCoinsViewController()
        return [allCoinsViewController, favouriteCoinsViewController]
    }
}
