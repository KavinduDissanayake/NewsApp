//
//  UIButton++.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

import UIKit



extension UIButton {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, cornerRadius: CGFloat = 0) {
        // Remove existing gradient
        if let oldLayer = (layer.sublayers?.compactMap { $0 as? CAGradientLayer })?.first {
            oldLayer.removeFromSuperlayer()
        }

        // Apply corner radius to button
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true

        // Create gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.cornerRadius = cornerRadius

        layer.insertSublayer(gradientLayer, at: 0)
    }
}
