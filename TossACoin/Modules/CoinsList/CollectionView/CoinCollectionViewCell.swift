//
//  CoinCollectionViewCell.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
import UIKit
import AlamofireImage

class CoinCollectionViewCell: UICollectionViewCell {
    fileprivate var coinName: UILabel = {() -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto", size: 23)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    fileprivate var price: UILabel = {() -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont(name: "Roboto", size: 16)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()

    fileprivate var companyName: UILabel = {() -> UILabel  in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto", size: 16)
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.3792319894, green: 0.384829402, blue: 0.3670491576, alpha: 1)
        label.textAlignment = .left
        return label
    }()

    fileprivate var regularMarketChangePercent: UILabel = {() -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto", size: 16)
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        setupSubviews()
    }
    
    public func loadData(model: CoinCellModel) {
        self.coinName.text = model.name
        self.companyName.text = model.companyName
        self.price.text = "\(model.price)\(model.financialCurrency.currencySymbol)"
        self.regularMarketChangePercent.text = "\(round(model.regularMarketChangePercent * 10) / 10)%"
        self.regularMarketChangePercent.textColor = model.regularMarketChangePercent < 0 ? #colorLiteral(red: 0.9908824563, green: 0.2480533719, blue: 0.2447027266, alpha: 1) : #colorLiteral(red: 0.2567636371, green: 0.7126277089, blue: 0.2477055192, alpha: 1)
    }
    
    // MARK: Style the CoinCollectionViewCell.
    func setupStyle() {
        layer.cornerRadius = 15
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    // MARK: Setup subviews.
    func setupSubviews() {
        contentView.addSubview(coinName)
        [
            coinName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            coinName.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
        ].forEach({$0.isActive = true})

        contentView.addSubview(companyName)

        [
            companyName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            companyName.topAnchor.constraint(equalTo: self.coinName.bottomAnchor, constant: 17)
        ].forEach({$0.isActive = true})
        
        contentView.addSubview(price)
        [
            price.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            price.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        ].forEach({$0.isActive = true})

        contentView.addSubview(regularMarketChangePercent)
        [
            regularMarketChangePercent.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            regularMarketChangePercent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ].forEach({$0.isActive = true})
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
}
