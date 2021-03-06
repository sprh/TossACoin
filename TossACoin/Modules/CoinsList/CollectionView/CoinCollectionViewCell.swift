//
//  CoinCollectionViewCell.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
import UIKit
import AlamofireImage

// MARK: - CollectionViewCell для Coin.
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
    
    fileprivate var image: UIImageView = {() -> UIImageView in
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        setupSubviews()
    }
    
    // Загрузка данных из модели.
    public func loadData(model: CoinCellModel) {
        self.coinName.text = model.name
        self.companyName.text = model.fullName
        self.price.text = model.price
        self.regularMarketChangePercent.textColor =
            model.changePercent.contains("-") ? #colorLiteral(red: 0.9908824563, green: 0.2480533719, blue: 0.2447027266, alpha: 1) : #colorLiteral(red: 0.2567636371, green: 0.7126277089, blue: 0.2477055192, alpha: 1)
        self.regularMarketChangePercent.text = "\(model.changePercent)%"
        setImage(imageUrl: model.imageUrl)
    }
    
    // Установка изображения.
    private func setImage(imageUrl: String) {
        guard let url = URL(string: APIClient.getImageUrl(imageUrl: imageUrl)) else { return }
        ImageCache.getImage(url: url) { (coinImage) in
            self.image.image = coinImage   
        }
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
        let height = contentView.bounds.height
        contentView.addSubview(image)
        [
            image.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: height - 16),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ].forEach({$0.isActive = true})
        
        contentView.addSubview(coinName)
        [
            coinName.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            coinName.leadingAnchor.constraint(equalTo: self.image.trailingAnchor, constant: 8)
        ].forEach({$0.isActive = true})

        contentView.addSubview(companyName)

        [
            companyName.topAnchor.constraint(equalTo: coinName.bottomAnchor, constant: 8),
            companyName.leadingAnchor.constraint(equalTo: coinName.leadingAnchor)
        ].forEach({$0.isActive = true})
        
        contentView.addSubview(price)
        [
            price.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            price.topAnchor.constraint(equalTo: coinName.topAnchor)
        ].forEach({$0.isActive = true})

        contentView.addSubview(regularMarketChangePercent)
        [
            regularMarketChangePercent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            regularMarketChangePercent.topAnchor.constraint(equalTo: companyName.topAnchor)
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
