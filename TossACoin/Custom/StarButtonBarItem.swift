//
//  StarButtonBarItem.swift
//  TossACoin
//
//  Created by Софья Тимохина on 01.03.2021.
//

import Foundation
import UIKit

class StarButtonBarItem: UIBarButtonItem {
    var buttonImage = UIImage(systemName: "star.fill")?.withTintColor(.orange)
    
    override init() {
        super.init()
        self.image = buttonImage
        self.style = .plain
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
