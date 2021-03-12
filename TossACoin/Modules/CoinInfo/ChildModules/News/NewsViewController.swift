//
//  NewsViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 07.03.2021.
//

import Foundation
import UIKit
import XLPagerTabStrip

class NewsViewController: UIViewController {
    let viewModel: NewsViewModel
    fileprivate let newsCollectionView =  UICollectionView(frame: CGRect(x: 0, y: 00, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200), collectionViewLayout: NewsCollectionViewFlowLayout())
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        // Настройка newsCollectionView.
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        newsCollectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCollectionViewCell")
        newsCollectionView.backgroundColor = .white
        view.addSubview(newsCollectionView)
    }
    
    // Получение новостей.
    func initCoinCollection() {
        viewModel.getNews
        { [weak self] in
            guard let `self` = self else { return }
            self.newsCollectionView.reloadData()
        }
    }
}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // Количество ячеек.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getArticlesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Получение ячейки.
        let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
        viewModel.createCell(cell: cell, at: indexPath.item)
        return cell
    }
    
    // Нажатие на ячейку.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.openArticle(at: indexPath.item)
    }
}

// Наследование XLPagerTabStrip. Дочерний контроллер.
extension NewsViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "News")
    }
}
