//
//  CustomControl.swift
//  StarRatingCustomUIControl
//
//  Created by Khurram Shahzad on 14/05/2020.
//  Copyright © 2020 Khurram Shahzad. All rights reserved.
//

import UIKit
import Foundation

class CustomControl: UIControl {
    
    var value: Int = 1
    let componentDimension: CGFloat = 40.0
    let componentCount: Int = 5
    let componentActiveColor: UIColor = .black
    let componentInactiveColor: UIColor = .gray
    var labelsArr: [UILabel] = []
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        
        setup()
    }
    
    override var intrinsicContentSize: CGSize {
      let componentsWidth = CGFloat(componentCount) * componentDimension
      let componentsSpacing = CGFloat(componentCount + 1) * 8.0
      let width = componentsWidth + componentsSpacing
      return CGSize(width: width, height: componentDimension)
    }
    
    private func setup() {
        labelsArr.removeAll()
        var padding: CGFloat = 8.0
        for index in 1...componentCount {
            let label = UILabel()
            label.tag = index
            label.font = UIFont.boldSystemFont(ofSize: 32.0)
            label.text = "\u{2605}"
            label.textColor = index == 1 ? componentActiveColor : componentInactiveColor
            label.frame = CGRect(x: padding, y: 0.0, width: componentDimension, height: componentDimension)
            padding += 8.0 + componentDimension
            
            labelsArr.append(label)
            self.addSubview(label)
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(at: touch, with: .begin)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(at: touch, with: .continue)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        if let finalTouch = touch {
            updateValue(at: finalTouch, with: .end)
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        
    }
    
    private func resetAllStars() {
        for aStar in self.labelsArr {
            aStar.textColor = componentInactiveColor
        }
    }
    
    func updateValue(at touch: UITouch, with type: TouchType) {
        let newRating = rating(for: touch)
        resetAllStars()
        for i in 0...newRating - 1 {
            labelsArr[i].textColor = componentActiveColor
        }
        self.value = newRating
        sendActions(for: .valueChanged)
    }
    
    func rating(for touch: UITouch) -> Int {
        let touchLocation = touch.location(in: self)
        var newRating: Int = 0
        for i in stride(from: (componentCount - 1), through: 0, by: -1) {
            let currentLabel = self.labelsArr[i]
            guard touchLocation.x > currentLabel.frame.origin.x else {
                continue
            }
            newRating = i + 1
            break
        }
        if newRating < 1 {
            return 1
        } else {
            return newRating
        }
    }
}

enum TouchType {
    case begin, `continue`, end, cancel
}
