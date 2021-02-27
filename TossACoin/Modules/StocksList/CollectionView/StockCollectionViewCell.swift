//
//  StockCollectionViewCell.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
import UIKit

class StockCollectionViewCell: UICollectionViewCell {
    fileprivate let stockName: UILabel = {() -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial-BoldMT", size: 18)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    fileprivate let favouriteButton: StarButton = {() -> StarButton in
        let starButton = StarButton(frame: CGRect(x: 50, y: 50, width: 30, height: 30))
        starButton.translatesAutoresizingMaskIntoConstraints = false
        return starButton
    }()

    fileprivate let companyIcon: UIImageView = {() -> UIImageView in
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .red
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.layer.borderWidth = 0
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image

    }()

    fileprivate let stockCurrentPrice: UILabel = {() -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont(name: "Arial-BoldMT", size: 18)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()

    fileprivate let fullName: UILabel = {() -> UILabel  in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AlNile", size: 12)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    fileprivate let dayDelta: UILabel = {() -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AlNile", size: 12)
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        setupSubviews()
    }
    
    // MARK: Style the StockCollectionViewCell.
    func setupStyle() {
        layer.cornerRadius = 15
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.7
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    // MARK: Setup subviews.
    func setupSubviews() {
        let height = contentView.bounds.size.height
        companyIcon.bounds.size = CGSize(width: height - 16, height: height - 16)
        contentView.addSubview(companyIcon)
        [
            companyIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            companyIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            companyIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            companyIcon.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: height - 8)
        ].forEach({$0.isActive = true})

        contentView.addSubview(stockName)
        [
            stockName.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            stockName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            stockName.leadingAnchor.constraint(equalTo: companyIcon.trailingAnchor, constant: 12),
            // TODO рассчитать
            stockName.trailingAnchor.constraint(equalTo: companyIcon.trailingAnchor, constant: 100)
        ].forEach({$0.isActive = true})

        contentView.addSubview(fullName)

        [
            fullName.topAnchor.constraint(equalTo: stockName.bottomAnchor),
            fullName.bottomAnchor.constraint(equalTo: stockName.bottomAnchor, constant: 14),
            fullName.leadingAnchor.constraint(equalTo: stockName.leadingAnchor),
            fullName.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ].forEach({$0.isActive = true})

        contentView.addSubview(favouriteButton)
        [
            favouriteButton.topAnchor.constraint(equalTo: stockName.topAnchor),
            favouriteButton.bottomAnchor.constraint(equalTo: stockName.bottomAnchor),
            // TODO рассчитать
            favouriteButton.leadingAnchor.constraint(equalTo: stockName.trailingAnchor, constant: 15),
            favouriteButton.trailingAnchor.constraint(equalTo: stockName.trailingAnchor, constant: 40)
        ].forEach({$0.isActive = true})

        contentView.addSubview(stockCurrentPrice)
        [
            stockCurrentPrice.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            stockCurrentPrice.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            stockCurrentPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17),
            // TODO рассчитать
            stockCurrentPrice.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -150)
        ].forEach({$0.isActive = true})

        contentView.addSubview(dayDelta)
        [
            dayDelta.topAnchor.constraint(equalTo: stockCurrentPrice.bottomAnchor),
            dayDelta.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            // TODO рассчитать
            dayDelta.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            dayDelta.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -112)
        ].forEach({$0.isActive = true})

        // TODO delete
        stockName.text = "YNDX"
        fullName.text = "Yandex, LLC"
        stockCurrentPrice.text = "4764,6 руб"
        dayDelta.text = "10%"
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
