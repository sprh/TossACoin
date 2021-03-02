//
//  SearchCoinViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation
import UIKit

class SearchCoinViewController: UIViewController {
    fileprivate var viewModel: SearchCoinViewModel!
    fileprivate var searchController: UISearchController = UISearchController()
    fileprivate var popularRequestsLabel: UILabel = { () -> UILabel in
        let label = UILabel()
        label.text = "Popular requests"
        label.font = UIFont(name: "Roboco", size: 20)
        return label
    }()
    
    fileprivate var historyLabel: UILabel = { () -> UILabel in
        let label = UILabel()
        label.text = "You've searched for this"
        return label
    }()
    
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
        setupSearchController()
        setupSubviews()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.prefersLargeTitles = false
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }
    
    private func setupSubviews() {
        self.view.addSubview(popularRequestsLabel)
        popularRequestsLabel.translatesAutoresizingMaskIntoConstraints = false
        [
            popularRequestsLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            popularRequestsLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            popularRequestsLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            popularRequestsLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ].forEach({$0.isActive = true})
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.definesPresentationContext = true
        searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Find ticker", attributes: nil)
        definesPresentationContext = true
        searchController.searchBar.tintColor = .orange
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension SearchCoinViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
