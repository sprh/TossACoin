//
//  MainInfoViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 07.03.2021.
//

import Foundation
import UIKit
import XLPagerTabStrip
import SwiftChart

class MainInfoViewController: UIViewController, IndicatorInfoProvider {
    let chart = Chart()
    lazy var labelLeadingMarginConstraint = NSLayoutConstraint()
    var label = UILabel()
    fileprivate var labelLeadingMarginInitialConstant: CGFloat! = 0
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "MainInfo")
    }
    
    fileprivate let viewModel: MainInfoViewModel!
    
    init(viewModel: MainInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews() {
        self.view.addSubview(chart)
        chart.translatesAutoresizingMaskIntoConstraints = false
        [
//            chart.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            chart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chart.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            chart.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            chart.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chart.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ].forEach({$0.isActive = true})
        
        viewModel.getData(ofType: .daily) { (result) -> () in
            let chartSeries = ChartSeries(result)
            chartSeries.color = .orange
            chartSeries.area = true
            self.chart.add(chartSeries)
        }
        
        chart.showXLabelsAndGrid = false
        chart.gridColor = .clear
        chart.delegate = self
        
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        labelLeadingMarginConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leadingMargin, multiplier: 1, constant: 0)
        [
            label.bottomAnchor.constraint(equalTo: chart.topAnchor, constant: -10),
            labelLeadingMarginConstraint
        ].forEach({$0.isActive = true})
        
        labelLeadingMarginInitialConstant = labelLeadingMarginConstraint.constant
    }
}

extension MainInfoViewController: ChartDelegate {
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        if let value = chart.valueForSeries(0, atIndex: indexes[0]) {
            
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
            label.text = numberFormatter.string(from: NSNumber(value: value))
            var constant = labelLeadingMarginInitialConstant + left - (label.frame.width / 2)
            
            if constant < labelLeadingMarginInitialConstant {
                constant = labelLeadingMarginInitialConstant
            }
            
            let rightMargin = chart.frame.width - label.frame.width
            if constant > rightMargin {
                constant = rightMargin
            }
            
            labelLeadingMarginConstraint.constant = constant
            
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        label.text = ""
        labelLeadingMarginConstraint.constant = labelLeadingMarginInitialConstant
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    
}
