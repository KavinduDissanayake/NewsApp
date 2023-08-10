//
//  UIView++.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

import UIKit


extension UIView {
    
    /// Set border and corner radius for any UIView
    ///
    /// - Parameters:
    ///   - width: Border width. Default is 1.0
    ///   - color: Border color. Default is black
    ///   - cornerRadius: Corner radius. Default is 0 (no rounded corners)
    func setBorder(width: CGFloat = 1.0, color: UIColor = .black, cornerRadius: CGFloat = 0) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = cornerRadius
        if cornerRadius > 0 {
            self.clipsToBounds = true
        }
    }
}


extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, cornerRadius: CGFloat = 0) {
        // Remove existing gradient
        if let oldLayer = (layer.sublayers?.compactMap { $0 as? CAGradientLayer })?.first {
            oldLayer.removeFromSuperlayer()
        }

        // Apply corner radius to view
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

extension UIView {
    
    private static var tapActionKey: Int = 0

    func addTapGesture(action: @escaping () -> Void) {
        isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tap)
        
        // Using associated object to retain the closure
        objc_setAssociatedObject(self, &UILabel.tapActionKey, action, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc private func tapAction() {
        if let action = objc_getAssociatedObject(self, &UILabel.tapActionKey) as? () -> Void {
            action()
        }
    }
}
