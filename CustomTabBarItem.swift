//
//  CustomTabBarItem.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-08.
//

import UIKit


class CustomTabBarItem: UIView {

    var NIB_NAME = "CustomTabBarItem"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        commonInit()
        
    }
    
    func commonInit(){

            guard let viewFromXib = loadViewFromNib() else { return }

            viewFromXib.frame = self.bounds

            addSubview(viewFromXib)

        }

        

        func loadViewFromNib() -> UIView? {

            let bundle = Bundle(for: type(of: self))

            let nib = UINib(nibName: NIB_NAME, bundle: bundle)

            return nib.instantiate(

                withOwner: self,

                options: nil).first as? UIView

        }
}
