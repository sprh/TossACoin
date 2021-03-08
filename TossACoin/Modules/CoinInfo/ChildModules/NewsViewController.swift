//
//  NewsViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 07.03.2021.
//

import Foundation
import UIKit
import XLPagerTabStrip

class NewsViewController: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "News")
    }
    
    override func viewDidLoad() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        super.viewDidLoad()
    }
}