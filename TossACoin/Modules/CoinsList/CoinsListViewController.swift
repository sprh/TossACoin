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
class CoinsListViewController: UIViewController {
    fileprivate let coinsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CoinsCollectionViewFlowLayout())
    fileprivate let viewModel: CoinsListViewModel!
    fileprivate let searchButton = SearchButtonBarItem()
    fileprivate let refreshControl = UIRefreshControl()
    
    init(viewModel: CoinsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        setupCollectionView()
        addSearchButton()
        initCoinCollection()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    // Кнопка поиска.
    private func addSearchButton() {
        self.navigationItem.rightBarButtonItem = searchButton
        searchButton.target = self
        searchButton.tintColor = .orange
        searchButton.action = #selector(startSearch)
    }
    
    // Нажатие на кнопку поиска.
    @objc func startSearch() {
//        UIAppearance.view.backgroundColor = UIColor.white
        let searchCoinViewController = viewModel.prepareSearchViewController()
        navigationController?.pushViewController(searchCoinViewController, animated: true)
    }
    
    // Настройка CollectionView.
    private func setupCollectionView() {
        coinsCollectionView.delegate = self
        coinsCollectionView.dataSource = self
        coinsCollectionView.register(CoinCollectionViewCell.self, forCellWithReuseIdentifier: "CoinCollectionViewCell")
        coinsCollectionView.backgroundColor = .white
        coinsCollectionView.refreshControl = refreshControl
        coinsCollectionView.refreshControl?.addTarget(self, action:
                                                    #selector(refreshCoins),
                                                    for: .valueChanged)
        self.view.addSubview(coinsCollectionView)
    }
    
    // Загрузка коллекции акций.
    func initCoinCollection() {
        viewModel.getCoins {
            self.coinsCollectionView.reloadData()
        }
    }
}

extension CoinsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        self.navigationController?.modalPresentationStyle = .fullScreen
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
        }
        DispatchQueue.main.async {
           self.coinsCollectionView.refreshControl?.endRefreshing()
        }
    }
}

extension CoinsListViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: viewModel.getTitle())
    }
    
    
}
