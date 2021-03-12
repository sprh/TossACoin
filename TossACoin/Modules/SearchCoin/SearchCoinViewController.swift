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
    fileprivate var searchController: UISearchController = UISearchController()
//    fileprivate var popularRequestsLabel: UILabel = { () -> UILabel in
//        let label = UILabel()
//        label.text = "Popular requests"
//        label.font = UIFont(name: "Roboco", size: 20)
//        return label
//    }()
    //    fileprivate var historyLabel: UILabel = { () -> UILabel in
    //        let label = UILabel()
    //        label.text = "You've searched for this"
    //        return label
    //    }()
    
    // Результаты поиска.
    fileprivate var coinsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CoinsCollectionViewFlowLayout())
    
    init(viewModel: SearchCoinViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let view = UIView()
        view.backgroundColor = .white
        title = "Search"
        self.view = view
        super.viewDidLoad()
        setupSearchController()
        setupSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupSubviews() {
        self.view.addSubview(coinsCollectionView)
        coinsCollectionView.delegate = self
        coinsCollectionView.dataSource = self
        coinsCollectionView.register(CoinCollectionViewCell.self, forCellWithReuseIdentifier: "CoinCollectionViewCell")
        coinsCollectionView.backgroundColor = .white
//        self.view.addSubview(popularRequestsLabel)
//        popularRequestsLabel.translatesAutoresizingMaskIntoConstraints = false
//        [
//            popularRequestsLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
//            popularRequestsLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            popularRequestsLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            popularRequestsLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20)
//        ].forEach({$0.isActive = true})
    }
    
    // Настройка поля поиска.
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.definesPresentationContext = true
        searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Find ticker", attributes: nil)
        definesPresentationContext = true
        searchController.searchBar.tintColor = .orange
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension SearchCoinViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        if text == ""  { return }
        viewModel.getSuggestions(symbol: text) {
        }
    }
}

extension SearchCoinViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = coinsCollectionView.dequeueReusableCell(withReuseIdentifier: "CoinCollectionViewCell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
}
