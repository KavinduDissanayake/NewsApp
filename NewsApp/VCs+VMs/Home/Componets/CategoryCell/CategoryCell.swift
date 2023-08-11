//
//  CategoryCell.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var cardBack: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(category:Category?) {
        titleLbl.text = (category?.name ?? "").localizedCapitalized
        
        if category?.isSelected ?? false {
            titleLbl.textColor = .white
//            let startColor = UIColor(red: 1, green: 0.23, blue: 0.27, alpha: 1)
//            let endColor = UIColor(red: 1, green: 0.50, blue: 0.53, alpha: 1)
            cardBack.layer.backgroundColor = UIColor.green.cgColor
        } else {
            titleLbl.textColor = .black
//            // making outer view corners, borders
//            cardBack.layer.cornerRadius = 13.0
//            cardBack.layer.borderWidth = 0.5
//            cardBack.layer.borderColor = #colorLiteral(red: 0.7647058824, green: 0.768627451, blue: 0.8, alpha: 1).cgColor
            cardBack.layer.backgroundColor = UIColor.blue.cgColor
        }
    }

}

extension UIView {
    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor,
                           UIColor.green.cgColor,
                           UIColor.black.cgColor]   // your colors go here
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}

//extension UIView {
//    func setGradientBackground(startColor: UIColor, endColor: UIColor, cornerRadius: CGFloat) {
//        // Remove any existing gradient layers
//        self.layer.sublayers?.forEach {
//            if $0 is CAGradientLayer {
//                $0.removeFromSuperlayer()
//            }
//        }
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = bounds
//        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        gradientLayer.cornerRadius = cornerRadius
//
//        // Add gradient layer
//        self.layer.insertSublayer(gradientLayer, at: 0)
//    }
//}
