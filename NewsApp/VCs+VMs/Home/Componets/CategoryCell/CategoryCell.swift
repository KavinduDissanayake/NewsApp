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
        cardBack.cornerViewRadius = 10

//
        if category?.isSelected ?? false {
            titleLbl.textColor = .white
            cardBack.layer.backgroundColor = UIColor(hexString: "#FF8086").cgColor
        } else {
            titleLbl.textColor = .black
            cardBack.layer.borderColor =   UIColor(hexString: "#F0F1FA").cgColor
            cardBack.layer.borderWidth =  1
            cardBack.layer.backgroundColor = UIColor.clear.cgColor

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
