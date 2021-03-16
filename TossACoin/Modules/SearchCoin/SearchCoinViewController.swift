//
//  SearchCoinViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation
import UIKit

// Поисковый контроллер.
class SearchCoinViewController: UIViewController {
    fileprivate var viewModel: SearchCoinViewModel!
    fileprivate var searchController: UISearchController = UISearchController(searchResultsController: nil)
    fileprivate var suggestionsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CoinsCollectionViewFlowLayout())
    
    init(viewModel: SearchCoinViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        view.backgroundColor = .white
        definesPresentationContext = false
        self.view = view
        setupSearchController()
        setupCollectionView()
    }

    func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.definesPresentationContext = true
        searchController.resignFirstResponder()
        searchController.becomeFirstResponder()
        searchController.isActive = true
        searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Find ticker", attributes: nil)
        searchController.searchBar.tintColor = .orange
        navigationItem.searchController = searchController
    }
    
    func setupCollectionView() {
        view.addSubview(suggestionsCollectionView)
        suggestionsCollectionView.register(CoinCollectionViewCell.self, forCellWithReuseIdentifier: "CoinCollectionViewCell")
        suggestionsCollectionView.backgroundColor = .white
        suggestionsCollectionView.delegate = self
        suggestionsCollectionView.dataSource = self
    }
}

extension SearchCoinViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension SearchCoinViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = suggestionsCollectionView.dequeueReusableCell(withReuseIdentifier: "CoinCollectionViewCell", for: indexPath) as! CoinCollectionViewCell
        // Запрос к модели.
//        viewModel.createCell(cell: cell, at: indexPath.item)
        return cell
    }
    
    
}
