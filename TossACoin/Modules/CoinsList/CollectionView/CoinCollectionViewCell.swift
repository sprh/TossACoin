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
        label.font = UIFont(name: "Arial-BoldMT", size: 18)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    fileprivate var favouriteButton: StarButton = {() -> StarButton in
        let starButton = StarButton(frame: CGRect(x: 50, y: 50, width: 30, height: 30))
        starButton.translatesAutoresizingMaskIntoConstraints = false
        return starButton
    }()

    fileprivate var price: UILabel = {() -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont(name: "Arial-BoldMT", size: 18)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()

    fileprivate var companyName: UILabel = {() -> UILabel  in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AlNile", size: 15)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    fileprivate var regularMarketChangePercent: UILabel = {() -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AlNile", size: 15)
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
        self.price.text = "\(model.price)"
        self.regularMarketChangePercent.text = "\(round(model.regularMarketChangePercent * 10) / 10)%"
        self.regularMarketChangePercent.textColor = model.regularMarketChangePercent < 0 ? .red : .green
    }
    
    // MARK: Style the CoinCollectionViewCell.
    func setupStyle() {
        layer.cornerRadius = 15
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.7
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    // MARK: Setup subviews.
    func setupSubviews() {
        contentView.addSubview(coinName)
        [
            coinName.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            coinName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            coinName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            // TODO рассчитать
            coinName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 100)
        ].forEach({$0.isActive = true})

        contentView.addSubview(companyName)

        [
            companyName.topAnchor.constraint(equalTo: coinName.bottomAnchor),
            companyName.bottomAnchor.constraint(equalTo: coinName.bottomAnchor, constant: 14),
            companyName.leadingAnchor.constraint(equalTo: coinName.leadingAnchor),
            companyName.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ].forEach({$0.isActive = true})

        contentView.addSubview(favouriteButton)
        [
            favouriteButton.topAnchor.constraint(equalTo: coinName.topAnchor),
            favouriteButton.bottomAnchor.constraint(equalTo: coinName.bottomAnchor),
            favouriteButton.leadingAnchor.constraint(equalTo: coinName.trailingAnchor, constant: 15),
            favouriteButton.trailingAnchor.constraint(equalTo: coinName.trailingAnchor, constant: 40)
        ].forEach({$0.isActive = true})

        contentView.addSubview(price)
        [
            price.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            price.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            price.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17),
            // TODO рассчитать
            price.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -150)
        ].forEach({$0.isActive = true})

        contentView.addSubview(regularMarketChangePercent)
        [
            regularMarketChangePercent.topAnchor.constraint(equalTo: price.bottomAnchor),
            regularMarketChangePercent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            // TODO рассчитать
            regularMarketChangePercent.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            regularMarketChangePercent.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -112)
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
