//
//  CoinInfoViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation
import UIKit
import XLPagerTabStrip

// MARK: - Экран с подробной информацией об акции.
// Использовала библиотеку XLPagerTabStrip для реализации чего-то похожего на Tab Page.
class CoinInfoViewController: ButtonBarPagerTabStripViewController {
    var viewModel: CoinInfoViewModel!
    
    // Тут содержится имя самой акции и имя компании.
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
        view.backgroundColor = .navigationAndTopColor
        setupView()
    }
    
    // Настройка вью.
    private func setupView() {
        self.view.backgroundColor = .backgroundColor
        view.addSubview(headerView)
        
        // Изменяем конструкции.
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
        // Настройка header view.
         setupHeaderView()
    }
    
    private func setupHeaderView() {
        headerView.backgroundColor = UIColor(named: "backgroundColor")
        // MARK: - Название акции.
        let coinName = UILabel()
        headerView.addSubview(coinName)
        coinName.translatesAutoresizingMaskIntoConstraints = false
        [
            coinName.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            coinName.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 0)
        ].forEach({$0.isActive = true})
        coinName.text = self.viewModel.getCoinName()
        coinName.font = .boldSystemFont(ofSize: 26)
        coinName.textColor = .black
        
        // MARK: - Название компании.
        let companyName = UILabel()
        headerView.addSubview(companyName)
        companyName.translatesAutoresizingMaskIntoConstraints = false
        [
            companyName.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            companyName.topAnchor.constraint(equalTo: coinName.bottomAnchor, constant: 8)
        ].forEach({$0.isActive = true})
        companyName.font = .systemFont(ofSize: 20)
        companyName.textColor = .gray
        companyName.text = self.viewModel.getCompanyName()
        companyName.textColor = .gray
        
        // MARK: - Кнопка добавления в избранное.
        let starButton = StarButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        headerView.addSubview(starButton)
        [
            starButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            starButton.topAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -15)
        ].forEach({$0.isActive = true})
        starButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        starButton.addTarget(self, action: #selector(addToFavoutite), for: .touchDown)
        
        // Проверка, есть ли уже в избранном.
        if(viewModel.isFavourite()) {
             starButton.setStatus(status: true)
        }
    }
    
    // Добавление в избранное.
    @objc func addToFavoutite() {
        viewModel.addToFavourite()
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
            oldCell?.imageView.tintColor = .orangeColor
            oldCell?.label.textColor = .black
            newCell?.label.textColor = .black
            oldCell?.label.font = .boldSystemFont(ofSize: 14)
            newCell?.label.font = .boldSystemFont(ofSize: 17)
        }
    }
    
    // Все дочерние экраны.
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let chartViewController =  viewModel.getChartViewController()
        // Вот это нужно из-за исправленной шапки.
        chartViewController.view.frame = CGRect(x: chartViewController.view.frame.minX, y: chartViewController.view.frame.minY, width: chartViewController.view.frame.width, height: view.frame.height - 150)
        let newsViewController = viewModel.getNewsViewController()
        // И это тоже.
        newsViewController.view.frame = CGRect(x: chartViewController.view.frame.minX, y: chartViewController.view.frame.minY, width: chartViewController.view.frame.width, height: view.frame.height - 150)
        return [chartViewController, newsViewController]
    }
}
