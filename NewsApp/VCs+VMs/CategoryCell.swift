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

    func configCell(category:Category?){
        titleLbl.text = (category?.name ?? "").localizedCapitalized
        if category?.isSelected ??  false {
            titleLbl.textColor = .white
            let startColor = UIColor(red: 1, green: 0.23, blue: 0.27, alpha: 1)
            let endColor = UIColor(red: 1, green: 0.50, blue: 0.53, alpha: 1)
            cardBack.setGradientBackground(colorOne: startColor, colorTwo: endColor, cornerRadius: 10)
           
        }else{
            titleLbl.textColor = .black
            cardBack.setBorder(width: 1.0, color: UIColor(hexString: "#f1f2fa"), cornerRadius: 10.0)
            cardBack.setGradientBackground(colorOne: .white, colorTwo: .white, cornerRadius: 10)
        }
    }
}
