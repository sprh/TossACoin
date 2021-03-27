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
    fileprivate var scrollView = UIScrollView()
    fileprivate var popularRequestsScrollView = UIScrollView()
    fileprivate let oldRequestsScrollView = UIScrollView()
    
    init(viewModel: SearchCoinViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setRequestsContentViewWidth(scrollView: popularRequestsScrollView)
        setRequestsContentViewWidth(scrollView: oldRequestsScrollView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        view.backgroundColor = .backgroundColor
        definesPresentationContext = true
        self.view = view
        setupSearchController()
        setupCollectionView()
        setupPopularRequestsButtons()
        setupOldRequestsButtons()
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
        scrollView.keyboardDismissMode = .onDrag
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .backgroundColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .backgroundColor
    }
    
    func setupCollectionView() {
        view.addSubview(suggestionsCollectionView)
        suggestionsCollectionView.register(CoinCollectionViewCell.self, forCellWithReuseIdentifier: "CoinCollectionViewCell")
        suggestionsCollectionView.backgroundColor = UIColor(named: "backgroundColor")
        suggestionsCollectionView.delegate = self
        suggestionsCollectionView.dataSource = self
        suggestionsCollectionView.alwaysBounceVertical = true
        suggestionsCollectionView.isHidden = true
    }
}

extension SearchCoinViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if (searchController.searchBar.text == nil || searchController.searchBar.text == "") {
            suggestionsCollectionView.isHidden = true
            scrollView.isHidden = false
            return
        }
        suggestionsCollectionView.isHidden = false
        scrollView.isHidden = true
        viewModel.getSuggestions(symbol: searchController.searchBar.text!) {
            self.suggestionsCollectionView.reloadData()
        }
    }
}

extension SearchCoinViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (viewModel.getSuggestionsCount() == 0) {
            suggestionsCollectionView.isHidden = true
            scrollView.isHidden = false
        }
        return viewModel.getSuggestionsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = suggestionsCollectionView.dequeueReusableCell(withReuseIdentifier: "CoinCollectionViewCell", for: indexPath) as! CoinCollectionViewCell
        viewModel.createCell(cell: cell, at: indexPath.item)
        return cell
    }
    
    // Нажатие на одну из ячеек CollectionView.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.addNewSearchingRequest(text: searchController.searchBar.text ?? "")
        setupButtons(scrollView: oldRequestsScrollView, buttonsTextArray: viewModel.getOldRequests())
        let getCoinViewController = viewModel.getCoinInfoViewController(cellIndex: indexPath.item)
        getCoinViewController.hidesBottomBarWhenPushed = true
        present(getCoinViewController, animated: true)
    }
}

extension SearchCoinViewController {
    @objc func buttonRequestTap(selector: RoundedButtonForDate) {
        guard let text = selector.titleLabel?.text else { return }
        searchController.searchBar.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func setupOldRequestsButtons() {
        let oldRequestsLabel = UILabel()
        scrollView.addSubview(oldRequestsLabel)
        oldRequestsLabel.translatesAutoresizingMaskIntoConstraints = false
        oldRequestsLabel.font = .systemFont(ofSize: 24)
        oldRequestsLabel.text = "You’ve searched for this"
        [
            oldRequestsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            oldRequestsLabel.topAnchor.constraint(equalTo: popularRequestsScrollView.bottomAnchor, constant: 20)
        ].forEach({$0.isActive = true})
        oldRequestsLabel.textColor = .black
        
        let oldRequestsView = UIView()
        oldRequestsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(oldRequestsView)
        [
            oldRequestsView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            oldRequestsView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            oldRequestsView.topAnchor.constraint(equalTo: oldRequestsLabel.bottomAnchor, constant: 20),
            oldRequestsView.bottomAnchor.constraint(equalTo: oldRequestsLabel.bottomAnchor, constant: 120)
        ].forEach({$0.isActive = true})
        
        oldRequestsScrollView.alwaysBounceHorizontal = true
        oldRequestsScrollView.translatesAutoresizingMaskIntoConstraints = false
        oldRequestsView.addSubview(oldRequestsScrollView)
        [
            oldRequestsScrollView.leadingAnchor.constraint(equalTo: oldRequestsView.leadingAnchor),
            oldRequestsScrollView.trailingAnchor.constraint(equalTo: oldRequestsView.trailingAnchor),
            oldRequestsScrollView.bottomAnchor.constraint(equalTo: oldRequestsView.bottomAnchor),
            oldRequestsScrollView.topAnchor.constraint(equalTo: oldRequestsView.topAnchor)
        ].forEach({$0.isActive = true})
        setupButtons(scrollView: oldRequestsScrollView, buttonsTextArray: viewModel.getOldRequests())
    }
    
    func setupPopularRequestsButtons() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        [
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach({$0.isActive = true})
        
        let popularRequestsLabel = UILabel()
        scrollView.addSubview(popularRequestsLabel)
        popularRequestsLabel.translatesAutoresizingMaskIntoConstraints = false
        popularRequestsLabel.font = .systemFont(ofSize: 24)
        popularRequestsLabel.text = "Popular requests"
        [
            popularRequestsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            popularRequestsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20)
        ].forEach({$0.isActive = true})
        popularRequestsLabel.textColor = .black
        
        let popularRequestsView = UIView()
        popularRequestsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(popularRequestsView)
        [
            popularRequestsView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            popularRequestsView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            popularRequestsView.topAnchor.constraint(equalTo: popularRequestsLabel.bottomAnchor, constant: 20),
            popularRequestsView.bottomAnchor.constraint(equalTo: popularRequestsLabel.bottomAnchor, constant: 120)
        ].forEach({$0.isActive = true})
        
        popularRequestsScrollView.alwaysBounceHorizontal = true
        popularRequestsScrollView.translatesAutoresizingMaskIntoConstraints = false
        popularRequestsView.addSubview(popularRequestsScrollView)
        [
            popularRequestsScrollView.leadingAnchor.constraint(equalTo: popularRequestsView.leadingAnchor),
            popularRequestsScrollView.trailingAnchor.constraint(equalTo: popularRequestsView.trailingAnchor),
            popularRequestsScrollView.bottomAnchor.constraint(equalTo: popularRequestsView.bottomAnchor),
            popularRequestsScrollView.topAnchor.constraint(equalTo: popularRequestsView.topAnchor)
        ].forEach({$0.isActive = true})
        // Не стала обращаться лишний раз по апи.
        setupButtons(scrollView: popularRequestsScrollView, buttonsTextArray: ["Apple", "Yandex", "Google", "Tesla", "First Solar", "Alibaba", "Facebook", "Bitcoin", "Litecoin", "Zoom", "Microsoft", "Netflix", "Altria", "Visa"])
    }
    
    func setupButtons(scrollView: UIScrollView, buttonsTextArray: [String]) {
        if(buttonsTextArray.count == 0) { return }
        
        
        let requestsButtonsHeight = CGFloat(100)
        var previous = RoundedButtonForDate()
        scrollView.subviews.forEach({if $0 is RoundedButtonForDate {$0.removeFromSuperview()}})
        for i in 0...buttonsTextArray.count - 1 {
            let button = RoundedButtonForDate()
            button.setTitle("  \(buttonsTextArray[i])  ", for: .normal)
            scrollView.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.bounds.size.height = 40
            button.addTarget(self, action: #selector(buttonRequestTap(selector:)), for: .touchUpInside)
            if (i < buttonsTextArray.count / 2) {
                [
                    button.leadingAnchor.constraint(equalTo: (i == 0 ? scrollView.leadingAnchor : previous.trailingAnchor), constant: 20),
                    button.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: -requestsButtonsHeight / 4)
                ].forEach({$0.isActive = true})
            }
            else {
                [
                    button.leadingAnchor.constraint(equalTo: (i == buttonsTextArray.count / 2 ? scrollView.leadingAnchor : previous.trailingAnchor), constant: 20),
                    button.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: requestsButtonsHeight / 4)
                    
                ].forEach({$0.isActive = true})
            }
            previous = button
        }
    }
    
    func setRequestsContentViewWidth(scrollView: UIScrollView) {
        var firstLineSizeOfContent: CGFloat = 0;
        var secondLineSizeOfContent: CGFloat = 0;
        for i in 0...scrollView.subviews.count - 1 {
            let subview = scrollView.subviews[i]
            if (subview is RoundedButtonForDate) {
                if (i < (scrollView.subviews.count - 1) / 2) {
                    firstLineSizeOfContent += subview.frame.size.width + 20
                }
                else {
                    secondLineSizeOfContent += subview.frame.size.width + 20
                }
            }
        }
        scrollView.contentSize.width = max(firstLineSizeOfContent, secondLineSizeOfContent) + 20
    }
}
