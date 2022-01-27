//
//  UIView.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 25/08/2021.
//

import UIKit

extension UIView {
    func applyGradient(startColor: UIColor = .green, midColor: UIColor = .gray, endColor: UIColor = .orange) {
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor, midColor.cgColor, endColor.cgColor]
        gradient.locations = [0.0, 0.5 , 1.0]
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}
