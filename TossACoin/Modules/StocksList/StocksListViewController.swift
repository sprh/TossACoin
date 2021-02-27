//
//  StocksListViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
import UIKit


final class StocksListViewController: UIViewController {
    var moduleOutput: StocksListViewOutput?
    var collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: StocksCollectionViewFlowLayout())
    
    init(output: StocksListViewOutput) {
        self.moduleOutput = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        setupSubviews()
        self.view = view
    }
}

extension StocksListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockCollectionViewCell", for: indexPath) as! StockCollectionViewCell
        cell.layer.cornerRadius = 15
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 0.07
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.backgroundColor = indexPath.row % 2 == 0 ? #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1) : .white
        return cell
    }
    
    func setupSubviews() {
        self.collectionView.backgroundColor = .white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(StockCollectionViewCell.self, forCellWithReuseIdentifier: "StockCollectionViewCell")
    }
}
extension StocksListViewController: StocksListViewInput {
    
}
