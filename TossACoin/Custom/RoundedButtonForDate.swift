//
//  RoundedButtonForDate.swift
//  TossACoin
//
//  Created by Софья Тимохина on 08.03.2021.
//

import Foundation
import UIKit
// Кнопка для выбора даты на ChartView.
class RoundedButtonForDate: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = .systemFont(ofSize: 20)
        didUnselect()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Изменение цвета фона и текста.
    func didSelect() {
        backgroundColor = .black
        setTitleColor(.white, for: .normal)
    }
    
    // Изменение цвета фона и текста.
    func didUnselect() {
        backgroundColor = ApplicationColors.lightOrangeColor
        setTitleColor(.black, for: .normal)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.sendHapticFeedback()
    }
    
    func sendHapticFeedback() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
}
