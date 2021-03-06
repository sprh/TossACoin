//
//  CoinsListViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 28.02.2021.
//

import Foundation
import UIKit

// MARK: - View Controller для экрана со всеми акциями.
class CoinsListViewController: UIViewController {
    fileprivate let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CoinsCollectionViewFlowLayout())
    fileprivate let viewModel: CoinsListViewModel!
    fileprivate let searchButton = SearchButtonBarItem()
    
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
        view.backgroundColor = .green
        self.view = view
        setupCollectionView()
        addSearchButton()
        initCoinCollection()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.prefersLargeTitles = false
//    }
    
    private func addSearchButton() {
        self.navigationItem.rightBarButtonItem = searchButton
        searchButton.target = self
        searchButton.tintColor = .orange
        searchButton.action = #selector(startSearch)
    }
    
    @objc func startSearch() {
        let searchCoinViewController = viewModel.prepareSearchViewController()
        searchCoinViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchCoinViewController, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CoinCollectionViewCell.self, forCellWithReuseIdentifier: "CoinCollectionViewCell")
        collectionView.backgroundColor = .white
        self.view.addSubview(collectionView)
    }
    
    func initCoinCollection() {
        viewModel.getCoins { [weak self] in
            guard let `self` = self else { return }
            self.collectionView.reloadData()
        }
    }
}

extension CoinsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCoinsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCollectionViewCell", for: indexPath) as! CoinCollectionViewCell
        viewModel.createCell(cell: cell, at: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let getCoinViewController = viewModel.getCoinInfoViewController(cellIndex: indexPath.item)
        getCoinViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.present(getCoinViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.item >= viewModel.getCoinsCount() - 2){
            initCoinCollection()
        }
    }
}

