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

class MainInfoViewController: UIViewController {
    fileprivate let chart = Chart()
    
    fileprivate lazy var labelLeadingMarginConstraint = NSLayoutConstraint()
    
    fileprivate lazy var labelWithPrice = UILabel()
    
    fileprivate var labelLeadingMarginInitialConstant: CGFloat! = 0
    
    fileprivate let labelWithLastPrice: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelChangePercent: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
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
        // MARK: - labelWithLastPrice
        self.view.addSubview(labelWithLastPrice)
        [
            labelWithLastPrice.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelWithLastPrice.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ].forEach({$0.isActive = true})
        labelWithLastPrice.text = viewModel.getLastPrice()
        
        // MARK: -labelChangePercent
        self.view.addSubview(labelChangePercent)
        [
            labelChangePercent.topAnchor.constraint(equalTo: labelWithLastPrice.bottomAnchor, constant: 8),
            labelChangePercent.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ].forEach({$0.isActive = true})
        labelChangePercent.text = "\(viewModel.getChangePercent())%"
        labelChangePercent.textColor = labelChangePercent.text!.contains("-") ? #colorLiteral(red: 0.9908824563, green: 0.2480533719, blue: 0.2447027266, alpha: 1) : #colorLiteral(red: 0.2567636371, green: 0.7126277089, blue: 0.2477055192, alpha: 1)

        // MARK: - Chart
        self.view.addSubview(chart)
        chart.translatesAutoresizingMaskIntoConstraints = false
        [
            chart.topAnchor.constraint(equalTo: labelChangePercent.bottomAnchor, constant: 40),
            chart.bottomAnchor.constraint(equalTo: labelChangePercent.bottomAnchor, constant: 300),
            chart.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chart.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ].forEach({$0.isActive = true})
        chart.showXLabelsAndGrid = false
        chart.gridColor = .clear
        chart.delegate = self
        setData(ofType: .daily)
        
        // MARK: - labelWithPrice
        self.view.addSubview(labelWithPrice)
        labelWithPrice.translatesAutoresizingMaskIntoConstraints = false
        labelLeadingMarginConstraint = NSLayoutConstraint(item: labelWithPrice, attribute: NSLayoutConstraint.Attribute.leadingMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leadingMargin, multiplier: 1, constant: 0)
        [
            labelWithPrice.bottomAnchor.constraint(equalTo: chart.topAnchor, constant: -10),
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
            labelWithPrice.text = numberFormatter.string(from: NSNumber(value: value))
            var constant = labelLeadingMarginInitialConstant + left - (labelWithPrice.frame.width / 2)
            
            if constant < labelLeadingMarginInitialConstant {
                constant = labelLeadingMarginInitialConstant
            }
            
            let rightMargin = chart.frame.width - labelWithPrice.frame.width
            if constant > rightMargin {
                constant = rightMargin
            }
            
            labelLeadingMarginConstraint.constant = constant
            
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        labelWithPrice.text = ""
        labelLeadingMarginConstraint.constant = labelLeadingMarginInitialConstant
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    func setData(ofType: ChartType) {
        viewModel.getData(ofType: ofType) { (result) -> () in
            let chartSeries = ChartSeries(result)
            chartSeries.color = .orange
            chartSeries.area = true
            self.chart.add(chartSeries)
        }
    }
}

extension MainInfoViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Chart")
    }
}
