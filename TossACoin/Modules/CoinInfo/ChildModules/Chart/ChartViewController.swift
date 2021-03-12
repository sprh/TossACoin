//
//  ChartMainInfoViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 07.03.2021.
//

import Foundation
import UIKit
import XLPagerTabStrip
import SwiftChart

class ChartViewController: UIViewController {
    // График.
    fileprivate let chart = Chart()
    // Label для информации о том, какая величина соответствует точке на графике.
    fileprivate lazy var labelWithPrice = UILabel()
    // Конструкции для labelWithPrice.
    fileprivate lazy var labelLeadingMarginConstraint = NSLayoutConstraint()
    fileprivate var labelLeadingMarginInitialConstant: CGFloat! = 0
    
    // Кнопки для изменения типа графика.
    fileprivate let dailyButton = RoundedButtonForDate(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    fileprivate let hourlyButton = RoundedButtonForDate(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    fileprivate let minuteButton = RoundedButtonForDate(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    // Стэк для кнопок.
    fileprivate var stackForButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    fileprivate let scrollView = UIScrollView()
    // Кнопка, которая на самом деле просто открывает браузер.
    fileprivate var buyButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Buy", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Последняя цена.
    fileprivate let labelWithLastPrice: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Процент изменения.
    fileprivate let labelChangePercent: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate let viewModel: ChartViewModel!
    
    init(viewModel: ChartViewModel) {
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
    
    override func viewDidAppear(_ animated: Bool) {
        // Изменение contentSize для scrollView.
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,
                                        height: UIScreen.main.bounds.height -
                                            view.safeAreaInsets.bottom +
                                            // Т к Buy привязана не к scrollView, а к view, высчитывается оптимальное расстояние.
                                            scrollView.convert(stackForButtons.frame.origin, to: buyButton).y - 120)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Сброс размера для того, чтобы позднее нормально его восстановить в viewDidAppear.
        scrollView.contentSize = CGSize.zero
    }
    
    private func setupSubviews() {
        // MARK: - ScrollView.
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach({$0.isActive = true})
        
        // MARK: - BuyButton.
        view.addSubview(buyButton)
        [
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buyButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width - 20),
            buyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            buyButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -75)
        ].forEach({$0.isActive = true})
        buyButton.addTarget(self, action: #selector(buyButtonTap), for: .touchDown)
        
        // MARK: - LabelWithLastPrice.
        scrollView.addSubview(labelWithLastPrice)
        [
            labelWithLastPrice.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            labelWithLastPrice.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20)
        ].forEach({$0.isActive = true})
        labelWithLastPrice.text = viewModel.getLastPrice()
        
        // MARK: - LabelChangePercent.
        scrollView.addSubview(labelChangePercent)
        [
            labelChangePercent.topAnchor.constraint(equalTo: labelWithLastPrice.bottomAnchor, constant: 8),
            labelChangePercent.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ].forEach({$0.isActive = true})
        labelChangePercent.text = "\(viewModel.getChangePercent())%"
        labelChangePercent.textColor = labelChangePercent.text!.contains("-") ? ApplicationColors.redPercent : ApplicationColors.greenPercent

        // MARK: - Chart.
        scrollView.addSubview(chart)
        chart.translatesAutoresizingMaskIntoConstraints = false
        [
            chart.topAnchor.constraint(equalTo: labelChangePercent.bottomAnchor, constant: 40),
            chart.bottomAnchor.constraint(equalTo: labelChangePercent.bottomAnchor, constant: 300),
            chart.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            chart.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ].forEach({$0.isActive = true})
        chart.showXLabelsAndGrid = false
        chart.gridColor = .clear
        chart.delegate = self
        chart.clearsContextBeforeDrawing = true
        setData(ofType: .daily)
        
        // MARK: - LabelWithPrice.
        scrollView.addSubview(labelWithPrice)
        labelWithPrice.translatesAutoresizingMaskIntoConstraints = false
        labelLeadingMarginConstraint = NSLayoutConstraint(item: labelWithPrice, attribute: NSLayoutConstraint.Attribute.leadingMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: scrollView, attribute: NSLayoutConstraint.Attribute.leadingMargin, multiplier: 1, constant: 0)
        [
            labelWithPrice.bottomAnchor.constraint(equalTo: chart.topAnchor, constant: -10),
            labelLeadingMarginConstraint
        ].forEach({$0.isActive = true})
        labelLeadingMarginInitialConstant = labelLeadingMarginConstraint.constant
    
    // MARK: - StackForButtons.
        scrollView.addSubview(stackForButtons)
        [
            stackForButtons.topAnchor.constraint(equalTo: chart.bottomAnchor, constant: 10),
            stackForButtons.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            stackForButtons.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            stackForButtons.bottomAnchor.constraint(equalTo: chart.bottomAnchor, constant: 60)
        ].forEach({$0.isActive = true})
        dailyButton.setTitle(" Daily ", for: .normal)
        
        stackForButtons.addSubview(dailyButton)
        [
            dailyButton.centerXAnchor.constraint(equalTo: stackForButtons.centerXAnchor, constant: 10),
            dailyButton.centerYAnchor.constraint(equalTo: stackForButtons.centerYAnchor)
        ].forEach({$0.isActive = true})
        dailyButton.addTarget(self, action: #selector(dailyButtonTap), for: .touchDown)
        dailyButton.didSelect()
        
        hourlyButton.setTitle(" Hourly ", for: .normal)
        stackForButtons.addSubview(hourlyButton)
        [
            hourlyButton.trailingAnchor.constraint(equalTo: dailyButton.leadingAnchor, constant: -10),
            hourlyButton.centerYAnchor.constraint(equalTo: stackForButtons.centerYAnchor)
        ].forEach({$0.isActive = true})
        hourlyButton.addTarget(self, action: #selector(hourlyButtonTap), for: .touchDown)
        
        minuteButton.setTitle(" Minute ", for: .normal)
        stackForButtons.addSubview(minuteButton)
        [
            minuteButton.leadingAnchor.constraint(equalTo: dailyButton.trailingAnchor, constant: 10),
            minuteButton.centerYAnchor.constraint(equalTo: stackForButtons.centerYAnchor)
        ].forEach({$0.isActive = true})
        minuteButton.addTarget(self, action: #selector(minuteButtonTap), for: .touchDown)
    }
}

extension ChartViewController {
    // В зависимости от того, какая кнопка была нажата, отправляется запрос в другой метод + изменяется цвет кнопок.
    @objc func dailyButtonTap() {
        dailyButton.didSelect()
        hourlyButton.didUnselect()
        minuteButton.didUnselect()
        // Используется enum.
        setData(ofType: .daily)
    }
    
    @objc func hourlyButtonTap() {
        dailyButton.didUnselect()
        hourlyButton.didSelect()
        minuteButton.didUnselect()
        setData(ofType: .hourly)
    }
    
    @objc func minuteButtonTap() {
        dailyButton.didUnselect()
        hourlyButton.didUnselect()
        minuteButton.didSelect()
        setData(ofType: .minute)
    }
    
    @objc func buyButtonTap() {
        viewModel.openBuyCoin()
    }
}

extension ChartViewController: ChartDelegate {
    func didEndTouchingChart(_ chart: Chart) {
    }
    
    // Нажатие на Chart.
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        guard let value = chart.valueForSeries(0, atIndex: indexes[0]) else {
            return}
            
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        labelWithPrice.text = numberFormatter.string(from: NSNumber(value: value))
        var constant = labelLeadingMarginInitialConstant + left - (labelWithPrice.frame.width / 2)
            
        // Проверка, что все ок и не было выходв за пределы графика.
        if constant < labelLeadingMarginInitialConstant {
            constant = labelLeadingMarginInitialConstant
        }
            
        let rightMargin = chart.frame.width - labelWithPrice.frame.width
        if constant > rightMargin {
            constant = rightMargin
        }
            
        // Изменение положения labelWithPrice.
        labelLeadingMarginConstraint.constant = constant
            
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        // Обновление конструкции.
        labelLeadingMarginConstraint.constant = labelLeadingMarginInitialConstant
    }
    
    // Обновление графика.
    func setData(ofType: ChartType) {
        viewModel.getData(ofType: ofType) { (result) -> () in
            let chartSeries = ChartSeries(result)
            chartSeries.color = ApplicationColors.orangeColor
            chartSeries.area = true
            self.chart.series = [chartSeries]
        }
    }
}

// Наследование XLPagerTabStrip. Дочерний контроллер.
extension ChartViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Chart")
    }
}
