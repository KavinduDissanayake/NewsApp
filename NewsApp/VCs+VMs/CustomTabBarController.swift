//
//  CustomTabBarController.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-09.
//

import UIKit
import SwiftUI

class CustomTabBarController: UITabBarController {
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }

    func setUpTabBar(){
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: tabBar.bounds.minY , width: tabBar.bounds.width - 60, height: tabBar.bounds.height + 10), cornerRadius: (tabBar.frame.width/2)).cgPath
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.fillColor = UIColor.white.cgColor
        layer.masksToBounds = false
        tabBar.layer.insertSublayer(layer, at: 0)
        tabBar.barTintColor = .clear
        tabBar.backgroundColor = .clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        if let items = tabBar.items {
            items.forEach { item in
                item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
            }
        }
        tabBar.itemWidth = 30.0
        tabBar.itemPositioning = .automatic
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-Regular", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-Regular", size: 10)!], for: .selected)
    }
}




//MARK: PREVIEW
struct CustomTabBarController_Previews: PreviewProvider {
    static var previews: some View {
        let storyboard = UIStoryboard(name: "BottomTabBar", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "CustomTabBarController") as? UITabBarController else {
            fatalError("Cannot instantiate SampleTabBarController from Main.storyboard")
        }
        return UIViewControllerWrapper(viewController: tabBarController).ignoresSafeArea()
    }
}

