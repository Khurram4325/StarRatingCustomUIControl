//
//  ViewController.swift
//  StarRatingCustomUIControl
//
//  Created by Khurram Shahzad on 14/05/2020.
//  Copyright © 2020 Khurram Shahzad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateRating(value: 1)
    }
    
    // MARK: - IBActions

    @IBAction func updateRating(_ ratingControl: CustomControl) {
        self.updateRating(value: ratingControl.value)
    }
    
    // MARK: - Helper Methods
    
    private func updateRating(value: Int) {
        self.title = "User Rating: \(value) \(value == 1 ? "star" : "stars")"
    }
}

