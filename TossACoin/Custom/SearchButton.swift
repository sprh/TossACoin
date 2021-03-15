//
//  SearchButton.swift
//  TossACoin
//
//  Created by Софья Тимохина on 15.03.2021.
//

import Foundation
import UIKit


// Кнопка поиска.
class SearchButton: UIButton {
    var buttonImage = UIImage(systemName: "magnifyingglass")?.withTintColor(.orange)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(buttonImage, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
