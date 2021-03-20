//
//  NewsCollectionViewCell.swift
//  TossACoin
//
//  Created by Софья Тимохина on 08.03.2021.
//

import Foundation
import UIKit

// UICollectionViewCell для NewsViewController.
class NewsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupStyle()
    }
    
    // Название новости.
    fileprivate let title: UILabel = { () -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 3
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // Изображение.
    fileprivate let articleImage: UIImageView = { () ->  UIImageView in
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Настройка стиля.
    func setupStyle() {
        layer.cornerRadius = 15
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    
    // Добавление элементов.
    private func setupSubviews() {
        let height = contentView.bounds.height
        // MARK: - Изображение.
        contentView.addSubview(articleImage)
        [
            articleImage.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: height - 16),
            articleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            articleImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            articleImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ].forEach({$0.isActive = true})
        
        // MARK: - Название.
        contentView.addSubview(title)
        [
            title.leadingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ].forEach({$0.isActive = true})
    }
    
    // Установка изображения.
    private func setImage(imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        
        // Обращение к псевдо кешу.
        ImageCache.getImage(url: url, placeholderName: "newspaper.fill") { (coinImage) in
            self.articleImage.image = coinImage
        }
    }
    
    // Загрузка данных.
    public func loadData(title: String, imageUrl: String) {
        self.title.text = title
        setImage(imageUrl: imageUrl)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.sendHapticFeedback()
    }
    
    // Обратная связь.
    func sendHapticFeedback() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
}
