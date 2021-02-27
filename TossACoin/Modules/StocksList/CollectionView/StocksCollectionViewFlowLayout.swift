//
//  CollectionViewFlowLayout.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
import UIKit

class StocksCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        scrollDirection = .vertical
        minimumLineSpacing = 8
        minimumInteritemSpacing = 16
        itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 90) // TODO Change size if need
        sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}
