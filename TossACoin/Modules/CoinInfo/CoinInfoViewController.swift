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
    
    lazy var barView: ButtonBarView = {
        let layout = UICollectionViewFlowLayout()
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 64)
        let collectionView = ButtonBarView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        return collectionView
      }()
    
    fileprivate var headerView = UIView()
    
    init(viewModel: CoinInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        setSettings()
        super.viewDidLoad()
        definesPresentationContext = true
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        buttonBarView.removeFromSuperview()
        containerView.removeFromSuperview()
        view.addSubview(headerView)
        view.addSubview(buttonBarView)
        view.addSubview(containerView)
        
        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.bounds.width,
            height: 100.0)
        
        buttonBarView.frame = CGRect(
            x: 0,
            y: headerView.frame.height,
            width: self.view.bounds.width,
            height: 50.0)

        containerView.frame = CGRect(
            x: 0,
            y: headerView.frame.height + buttonBarView.frame.height,
            width: self.view.bounds.width,
            height: self.view.bounds.height - (headerView.frame.height + buttonBarView.frame.height))
         setupHeaderView()
    }
    
    private func setupHeaderView() {
        let coinName = UILabel()
        let companyName = UILabel()
        let starButton = StarButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        headerView.addSubview(coinName)
        headerView.addSubview(companyName)
        headerView.addSubview(starButton)
        
        coinName.translatesAutoresizingMaskIntoConstraints = false
        [
            coinName.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            coinName.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 0)
        ].forEach({$0.isActive = true})
        coinName.text = self.viewModel.getCoinName()
        coinName.font = .boldSystemFont(ofSize: 26)
        coinName.text = self.viewModel.getCoinName()
        
        companyName.translatesAutoresizingMaskIntoConstraints = false
        [
            companyName.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            companyName.topAnchor.constraint(equalTo: coinName.bottomAnchor, constant: 8)
        ].forEach({$0.isActive = true})
        companyName.font = .systemFont(ofSize: 20)
        companyName.textColor = .gray
        companyName.text = self.viewModel.getCompanyName()
        
        [
            starButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            starButton.topAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -15)
        ].forEach({$0.isActive = true})
        starButton.imageEdgeInsets = UIEdgeInsets(top: 40, left: 20, bottom: 40, right: 40)
        starButton.addTarget(self, action: #selector(addToFavoutite), for: .touchDown)
        if(viewModel.isFavourite()) {
             starButton.setStatus(status: true)
        }
    }
    
    @objc func addToFavoutite() {
        viewModel.addToFavourite()
    }
    
    private func setSettings() {
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
            newCell?.label.textColor = ApplicationColors.orangeColor
            oldCell?.label.font = .boldSystemFont(ofSize: 14)
            newCell?.label.font = .boldSystemFont(ofSize: 17)
        }
        containerView?.isScrollEnabled = false
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let mainViewController =  viewModel.getChartViewController()
        let newsViewController = viewModel.getNewsViewController()
        return [mainViewController, newsViewController]
    }
}
