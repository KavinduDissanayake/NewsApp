//
//  CardView.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-09.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var shadowOffsetWidth: CGFloat = 0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var shadowOffsetHeight: CGFloat = 5 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.2 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 10 {
        didSet {
            setupView()
        }
    }
    
    override func layoutSubviews() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
}
