//
//  NewsViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 07.03.2021.
//

import Foundation
import UIKit
import XLPagerTabStrip

class NewsViewController: UIViewController, IndicatorInfoProvider {
    let viewModel: NewsViewModel
    fileprivate let collectionView =  UICollectionView(frame: CGRect(x: 0, y: 00, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200), collectionViewLayout: NewsCollectionViewFlowLayout())
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "News")
    }
    
    override func viewDidLoad() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        super.viewDidLoad()
        setupSubviews()
        initCoinCollection()
    }
    
    func setupSubviews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCollectionViewCell")
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    func initCoinCollection() {
        viewModel.getNews
        { [weak self] in
            guard let `self` = self else { return }
            self.collectionView.reloadData()
        }
    }
}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getArticlesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
        viewModel.createCell(cell: cell, at: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row >= viewModel.getArticlesCount() - 2) {
            initCoinCollection()
        }
    }
}
