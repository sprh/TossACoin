//
//  ChartMainInfoViewController.swift
//  TossACoin
//
//  Created by Софья Тимохина on 07.03.2021.
//

import Foundation
import UIKit
import XLPagerTabStrip
import AAInfographics

class ChartViewController: UIViewController {
    // График
    fileprivate let chart = AAChartView()
    // Кнопки для изменения типа графика.
    fileprivate let dailyButton = RoundedButtonForDate(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    fileprivate let hourlyButton = RoundedButtonForDate(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    fileprivate let minuteButton = RoundedButtonForDate(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    
    fileprivate var times: [String] = []
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
        view.backgroundColor = UIColor(named: "backgroundColor")
        self.view = view
        view.exerciseAmbiguityInLayout()
        super.viewDidLoad()
        setupSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Изменение contentSize для scrollView.
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,
                                        height: UIScreen.main.bounds.height -
                                            view.safeAreaInsets.bottom - 120)
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
        view.addSubview(chart)
        chart.translatesAutoresizingMaskIntoConstraints = false
        [
            chart.topAnchor.constraint(equalTo: labelChangePercent.bottomAnchor, constant: 40),
            chart.bottomAnchor.constraint(equalTo: labelChangePercent.bottomAnchor, constant: 300),
            chart.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            chart.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ].forEach({$0.isActive = true})
        chart.clearsContextBeforeDrawing = true
        setData(ofType: .daily)
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
            dailyButton.centerXAnchor.constraint(equalTo: stackForButtons.centerXAnchor, constant: 0),
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
    
    // Обновление графика.
    func setData(ofType: ChartType) {
        // Получение данных из модели.
        viewModel.getData(ofType: ofType) { [self] (values, times) -> () in
            // Настройка графика.
            let chartModel = AAChartModel()
                .chartType(.spline)
                .categories(times)
                .yAxisTitle("")
                .markerRadius(0)
                .legendEnabled(false)
                .dataLabelsEnabled(false)
                .xAxisVisible(false)
                .yAxisVisible(false)
                .backgroundColor(AAColor.clear)
                .series([
                    AASeriesElement()
                        .name(self.viewModel.getName())
                        .lineWidth(4)
                        .color(ApplicationColors.orangeColorAAColor)
                        .data(values),
                    ])
            // Отрисовка.
            self.chart.aa_drawChartWithChartModel(chartModel)
        }
    }
}

// Наследование XLPagerTabStrip. Дочерний контроллер.
extension ChartViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Chart")
    }
}
