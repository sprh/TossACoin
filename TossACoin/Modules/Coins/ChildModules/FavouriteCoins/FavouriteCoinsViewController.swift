//
//  FavouriteCoinsViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 12.03.2021.
//

import Foundation
import UIKit
import XLPagerTabStrip

class FavouriteCoinsViewController: UIViewController {
    fileprivate let coinsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CoinsCollectionViewFlowLayout())
    fileprivate let viewModel: FavouriteCoinsViewModel!
    fileprivate let refreshControl = UIRefreshControl()
    
    init(viewModel: FavouriteCoinsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        self.view = view
        setupCollectionView()
        initCoinCollection()
        setupRefreshControl()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initCoinCollection()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        coinsCollectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150)
    }
    
    // Настройка CollectionView.
    private func setupCollectionView() {
        coinsCollectionView.delegate = self
        coinsCollectionView.dataSource = self
        coinsCollectionView.register(CoinCollectionViewCell.self, forCellWithReuseIdentifier: "CoinCollectionViewCell")
        coinsCollectionView.backgroundColor = UIColor(named: "backgroundColor")
        coinsCollectionView.refreshControl = refreshControl
        coinsCollectionView.refreshControl?.addTarget(self, action:
                                                    #selector(refreshCoins),
                                                    for: .valueChanged)
        self.view.addSubview(coinsCollectionView)
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = ApplicationColors.orangeColor
        refreshControl.addTarget(self, action: #selector(refreshCoins), for: .valueChanged)
        coinsCollectionView.refreshControl = refreshControl
    }
    
    // Загрузка коллекции акций.
    func initCoinCollection() {
        viewModel.getCoins {
            self.coinsCollectionView.reloadData()
        }
    }
}

extension FavouriteCoinsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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

extension FavouriteCoinsViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Favourite")
    }
}
