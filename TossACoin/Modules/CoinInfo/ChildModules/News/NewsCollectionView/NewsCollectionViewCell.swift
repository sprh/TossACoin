//
//  NewsCollectionViewCell.swift
//  TossACoin
//
//  Created by Софья Тимохина on 08.03.2021.
//

import Foundation
import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    fileprivate let title: UILabel = { () -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22)
        label.numberOfLines = 3
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let articleImage: UIImageView = { () ->  UIImageView in
        let image = UIImageView()
        // TODO: Возможно, придется изменить.
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        let height = contentView.bounds.height
        contentView.addSubview(articleImage)
        [
            articleImage.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: height - 16),
            articleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            articleImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            articleImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ].forEach({$0.isActive = true})
        
        contentView.addSubview(title)
        [
            title.leadingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ].forEach({$0.isActive = true})
    }
    
    // Установка изображения.
    private func setImage(imageUrl: String) {
        guard let url = URL(string: APIClient.getImageUrl(imageUrl: imageUrl)) else { return }
        
        ImageCache.getImage(url: url, placeholderName: "newspaper.fill") { (coinImage) in
            self.articleImage.image = coinImage
        }
    }
    
    public func loadData(article: Article) {
        title.text = article.title
        setImage(imageUrl: "https://i.insider.com/6038b76dd920880018592239?width=1200&format=jpeg")
        // TODO: Доделать.
    }
}
