//
//  UIViewExtension.swift
//  StarRatingCustomUIControl
//
//  Created by Khurram Shahzad on 14/05/2020.
//  Copyright © 2020 Khurram Shahzad. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
  // "Flare view" animation sequence
  func performFlare() {
    func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
    func unflare() { transform = .identity }
    
    UIView.animate(withDuration: 0.3,
                   animations: { flare() },
                   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
  }
}
