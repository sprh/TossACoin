//
//  CoinsListViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 28.02.2021.
//

import Foundation
import UIKit

class CoinsListViewController: UIViewController {
    fileprivate let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CoinsCollectionViewFlowLayout())
    fileprivate let viewModel: CoinsListViewModel!
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let searchCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CoinsCollectionViewFlowLayout())
    
    init(viewModel: CoinsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        let view = UIView()
        view.backgroundColor = .green
        self.view = view
        setupCollectionView()
        setupSearchController()
        initCoinCollection()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CoinCollectionViewCell.self, forCellWithReuseIdentifier: "CoinCollectionViewCell")
        collectionView.backgroundColor = .white
        self.view.addSubview(collectionView)
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        searchController.searchBar.tintColor = .orange
        definesPresentationContext = true
        navigationItem.searchController = searchController
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
        cell.backgroundColor = indexPath.item % 2 == 0 ? #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1) : #colorLiteral(red: 0.9498714805, green: 1, blue: 0.7609667182, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coinData = CoinData()
        let viewModel =  CoinInfoViewModel(data: coinData)
        let viewController = CoinInfoViewController(viewModel: viewModel)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.item >= viewModel.getCoinsCount() - 1){
            initCoinCollection()
        }
    }
}

extension CoinsListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
