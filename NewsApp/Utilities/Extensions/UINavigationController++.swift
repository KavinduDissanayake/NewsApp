//
//  UINavigationController++.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

import UIKit

extension UINavigationController {

    var isHiddenHairline: Bool {
        get {
            guard let hairline = findHairlineImageViewUnder(navigationBar) else { return true }
            return hairline.isHidden
        }
        set {
            if let hairline = findHairlineImageViewUnder(navigationBar) {
                hairline.isHidden = newValue
            }
        }
    }

    private func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }

        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }

        return nil
    }
}





extension UINavigationBar {
  func update(backroundColor: UIColor? = nil, titleColor: UIColor? = nil) {
    if #available(iOS 15, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      if let backroundColor = backroundColor {
        appearance.backgroundColor = backroundColor
      }
      if let titleColor = titleColor {
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
      }
      standardAppearance = appearance
      scrollEdgeAppearance = appearance
    } else {
      barStyle = .blackTranslucent
      if let backroundColor = backroundColor {
        barTintColor = backroundColor
      }
      if let titleColor = titleColor {
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
      }
    }
  }
}
