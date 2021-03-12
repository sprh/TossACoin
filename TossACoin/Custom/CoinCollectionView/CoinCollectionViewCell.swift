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
    // Название акции (тикет).
    fileprivate var coinName: UILabel = {() -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    // Последняя цена.
    fileprivate var price: UILabel = {() -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()

    // Название компании.
    fileprivate var companyName: UILabel = {() -> UILabel  in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.3792319894, green: 0.384829402, blue: 0.3670491576, alpha: 1)
        label.textAlignment = .left
        return label
    }()

    // Процент изменения.
    fileprivate var regularMarketChangePercent: UILabel = {() -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    // Изображение.
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Загрузка данных из модели.
    public func loadData(model: CoinCellModel) {
        self.coinName.text = model.name
        self.companyName.text = model.fullName
        self.price.text = model.price
        self.regularMarketChangePercent.textColor =
            model.changePercent.contains("-") ? ApplicationColors.redPercent : ApplicationColors.greenPercent
        self.regularMarketChangePercent.text = "\(model.changePercent)%"
        setImage(imageUrl: model.imageUrl)
    }
    
    // Установка изображения.
    private func setImage(imageUrl: String) {
        guard let url = URL(string: APIClient.getImageUrl(imageUrl: imageUrl)) else { return }
        // Ображение к кешу. Кеш немного псевдо, т к в том случае, если изображение не было получено, оно подгружается и добавляется в кеш. Отправляется также placeholder - изображение, которое в случае неудачи послужит заменой.
        ImageCache.getImage(url: url, placeholderName: "dollarsign.square.fill") { (coinImage) in
            self.image.image = coinImage   
        }
    }
    
    // Добавление стиля.
    func setupStyle() {
        layer.cornerRadius = 15
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    // MARK: - Добавление элементов.
    func setupSubviews() {
        let height = contentView.bounds.height
        // MARK: - Изображение.
        contentView.addSubview(image)
        [
            image.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: height - 16),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ].forEach({$0.isActive = true})
        
        // MARK: - Имя.
        contentView.addSubview(coinName)
        [
            coinName.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            coinName.leadingAnchor.constraint(equalTo: self.image.trailingAnchor, constant: 8)
        ].forEach({$0.isActive = true})

        // MARK: - Название компании.
        contentView.addSubview(companyName)

        [
            companyName.topAnchor.constraint(equalTo: coinName.bottomAnchor, constant: 8),
            companyName.leadingAnchor.constraint(equalTo: coinName.leadingAnchor)
        ].forEach({$0.isActive = true})
        
        // MARK: - Цена.
        contentView.addSubview(price)
        [
            price.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            price.topAnchor.constraint(equalTo: coinName.topAnchor)
        ].forEach({$0.isActive = true})

        // MARK: - Процент изменения.
        contentView.addSubview(regularMarketChangePercent)
        [
            regularMarketChangePercent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            regularMarketChangePercent.topAnchor.constraint(equalTo: companyName.topAnchor)
        ].forEach({$0.isActive = true})
    }

    // TODO: Добавить нажатие.
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
