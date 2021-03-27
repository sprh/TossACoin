//
//  CoinsListViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 28.02.2021.
//

import Foundation
import UIKit
import XLPagerTabStrip

// MARK: - View Controller для экрана со всеми акциями.
class AllCoinsViewController: UIViewController {
    fileprivate let coinsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CoinsCollectionViewFlowLayout())
    fileprivate let viewModel: AllCoinsViewModel!
    
    init(viewModel: AllCoinsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        view.backgroundColor = .backgroundColor
        self.view = view
        setupCollectionView()
        initCoinCollection()
        setupRefreshControl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height: CGFloat = (navigationController?.navigationBar.frame.height ?? 0) + (navigationController?.tabBarController?.tabBar.frame.height ?? 0)
        coinsCollectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - height)
    }

    // Настройка CollectionView.
    private func setupCollectionView() {
        self.view.addSubview(coinsCollectionView)
        coinsCollectionView.delegate = self
        coinsCollectionView.dataSource = self
        coinsCollectionView.register(CoinCollectionViewCell.self, forCellWithReuseIdentifier: "CoinCollectionViewCell")
        coinsCollectionView.backgroundColor = .backgroundColor
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .orangeColor
        refreshControl.addTarget(self, action: #selector(refreshCoins), for: .valueChanged)
        coinsCollectionView.refreshControl = refreshControl
    }
    
    // Загрузка коллекции акций.
    func initCoinCollection() {
        viewModel.getCoins { [self] in
            self.coinsCollectionView.reloadData()
        }
    }
}

extension AllCoinsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // Количество ячеек.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCoinsCount()
    }
    
    // Получение новой ячейки.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = coinsCollectionView.dequeueReusableCell(withReuseIdentifier: "CoinCollectionViewCell", for: indexPath) as! CoinCollectionViewCell
        // Запрос к модели.
        viewModel.createCell(cell: cell, at: indexPath.item)
        return cell
    }
    
    // Нажатие на одну из ячеек CollectionView.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let getCoinViewController = viewModel.getCoinInfoViewController(cellIndex: indexPath.item)
        getCoinViewController.hidesBottomBarWhenPushed = true
        present(getCoinViewController, animated: true)
    }
    
    // Догрузка коллекции
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.item >= viewModel.getCoinsCount() - 2){
             initCoinCollection()
        }
    }
    
    // Обновление. Функция привязана к UIRefreshControl.
    @objc func refreshCoins() {
        viewModel.refresh {
            self.initCoinCollection()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
               self.coinsCollectionView.refreshControl?.endRefreshing()
            }
        }
    }
}

extension AllCoinsViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "All coins")
    }
}
