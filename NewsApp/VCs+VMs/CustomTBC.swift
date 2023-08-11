//
//  CustomTabBarController.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-09.
//

import UIKit
import SwiftUI

class CustomTBC: UITabBarController {
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        setUpTabBarItems()
        removeDefaultTint()
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
    
    
    func setUpTabBarItems() {
            // Assuming you have view controllers set up
            if let viewControllers = self.viewControllers {
                for (index, viewController) in viewControllers.enumerated() {
                    switch index {
                    case 0:
                        viewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "ic_inactive_home"), selectedImage: UIImage(named: "ic_active_home"))
                    case 1:
                        viewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "ic_inactive_hart"), selectedImage: UIImage(named: "ic_active_hart"))
                    case 2:
                        viewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "ic_inactive_profile"), selectedImage: UIImage(named: "ic_active_profile"))
                    default:
                        break
                    }
                }
            }
        }
        
        func removeDefaultTint() {
            tabBar.tintColor = UIColor(hexString: "#FF3A44") // Color for the active icon
            tabBar.unselectedItemTintColor = UIColor.systemGray // Color for the inactive icons
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

