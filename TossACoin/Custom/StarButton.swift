//
//  StarButton.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation
import UIKit

// MARK: - Star button, which allows the user to add a stock to his favourite stocks.
final class StarButton: UIButton {
    var image = UIImage(systemName: "star.fill")
    var status: Bool = false {
        didSet {
            self.update()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStatus(status: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        UIView.transition(with: self, duration: 0.10, options: .transitionCrossDissolve, animations: {
            self.setImage(UIImage(systemName: "star.fill")?.withTintColor((self.status ? #colorLiteral(red: 1, green: 0.7903846502, blue: 0.1099510416, alpha: 1): #colorLiteral(red: 0.7293314338, green: 0.7294582725, blue: 0.7293233275, alpha: 1)), renderingMode: .alwaysOriginal), for: .normal)
        }, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.sendHapticFeedback()
        setStatus(status: !status)
    }
    
    func setStatus(status: Bool) {
        self.status = status
    }
    func sendHapticFeedback() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
}
