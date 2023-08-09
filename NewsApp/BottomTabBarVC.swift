//
//  BottomTabBarVC.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-07.
//

import UIKit
class NewBottomTabBarVC: UITabBarController {
    
}
class BottomTabBarVC: BaseVC {

//    @IBOutlet weak var viewForTab: UIView!
    @IBOutlet weak var tabBarCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      //  setupTabCV()
        tabBarUIStep()
    }
    

    func tabBarUIStep(){
//        viewForTab.layer.cornerRadius = viewForTab.frame.size.height / 2
//        viewForTab.clipsToBounds = true
    }
}

//extension BottomTabBarVC:UICollectionViewDelegate, UICollectionViewDataSource {
//    func setupTabCV() {
//        self.tabBarCollection.register(UINib(nibName: "CustomTabItem", bundle: Bundle.main), forCellWithReuseIdentifier: "CustomTabItem")
//        self.tabBarCollection.delegate = self
//        self.tabBarCollection.dataSource = self
//
//    }
//
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomTabItem", for: indexPath) as? CustomTabItem else {
//            return UICollectionViewCell()
//        }
//
//        return cell
//    }
//
//
//}
import UIKit

@IBDesignable
class CustomizedTabBar: UITabBar {

    private var shapeLayer: CALayer?

    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }

        self.shapeLayer = shapeLayer
    }

    override func draw(_ rect: CGRect) {
        self.addShape()
    }

//    func createPath() -> CGPath {
//        let path = UIBezierPath()
//
//        // Constants
//        let cornerRadius: CGFloat = 50
//        let tabBarHeight = self.bounds.height - 32 // height with bottom padding
//        let padding: CGFloat = 20
//
//        // Define the tab bar shape
//        path.move(to: CGPoint(x: 0 + padding, y: 0))
//        path.addLine(to: CGPoint(x: self.frame.width - padding, y: 0))
//        path.addLine(to: CGPoint(x: self.frame.width - padding, y: tabBarHeight - cornerRadius))
//        path.addArc(withCenter: CGPoint(x: self.frame.width - padding - cornerRadius, y: tabBarHeight - cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
//        path.addLine(to: CGPoint(x: padding + cornerRadius, y: tabBarHeight))
//        path.addArc(withCenter: CGPoint(x: padding + cornerRadius, y: tabBarHeight - cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: true)
//        path.addLine(to: CGPoint(x: 0 + padding, y: 0))
//        path.close()
//
//        return path.cgPath
//    }
//
//    func createPath() -> CGPath {
//        let path = UIBezierPath()
//
//        // Constants
//        let cornerRadius: CGFloat = 50
//        let tabBarHeight = self.bounds.height - 32 // height with bottom padding
//        let padding: CGFloat = 20
//
//        // Starting from top-left after the rounded corner
//        path.move(to: CGPoint(x: padding + cornerRadius, y: 0))
//
//        // Move to top-right with rounding the corner
//        path.addLine(to: CGPoint(x: self.frame.width - padding - cornerRadius, y: 0))
//        path.addArc(withCenter: CGPoint(x: self.frame.width - padding - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: -CGFloat.pi / 2, endAngle: 0, clockwise: true)
//
//        // Move down to bottom-right just above the rounded corner
//        path.addLine(to: CGPoint(x: self.frame.width - padding, y: tabBarHeight - cornerRadius))
//
//        // Add bottom-right rounded corner
//        path.addArc(withCenter: CGPoint(x: self.frame.width - padding - cornerRadius, y: tabBarHeight - cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
//
//        // Move to bottom-left, just after the rounded corner
//        path.addLine(to: CGPoint(x: padding + cornerRadius, y: tabBarHeight))
//
//        // Add bottom-left rounded corner
//        path.addArc(withCenter: CGPoint(x: padding + cornerRadius, y: tabBarHeight - cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: true)
//
//        // Move to top-left just below the rounded corner
//        path.addLine(to: CGPoint(x: padding, y: cornerRadius))
//
//        // Add top-left rounded corner
//        path.addArc(withCenter: CGPoint(x: padding + cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi, endAngle: 1.5 * CGFloat.pi, clockwise: true)
//
//        path.close()
//
//        return path.cgPath
//    }
    func createPath() -> CGPath {
        let path = UIBezierPath()
        
        // Constants
        let cornerRadius: CGFloat = 50
        let tabBarHeight = self.bounds.height - 32 // height with bottom padding
        let leadingPadding: CGFloat = 43
        let trailingPadding: CGFloat = 42

        // Starting from top-left after the rounded corner
        path.move(to: CGPoint(x: leadingPadding + cornerRadius, y: 0))
        
        // Move to top-right with rounding the corner
        path.addLine(to: CGPoint(x: self.frame.width - trailingPadding - cornerRadius, y: 0))
        path.addArc(withCenter: CGPoint(x: self.frame.width - trailingPadding - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: -CGFloat.pi / 2, endAngle: 0, clockwise: true)
        
        // Move down to bottom-right just above the rounded corner
        path.addLine(to: CGPoint(x: self.frame.width - trailingPadding, y: tabBarHeight - cornerRadius))
        
        // Add bottom-right rounded corner
        path.addArc(withCenter: CGPoint(x: self.frame.width - trailingPadding - cornerRadius, y: tabBarHeight - cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        
        // Move to bottom-left, just after the rounded corner
        path.addLine(to: CGPoint(x: leadingPadding + cornerRadius, y: tabBarHeight))
        
        // Add bottom-left rounded corner
        path.addArc(withCenter: CGPoint(x: leadingPadding + cornerRadius, y: tabBarHeight - cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: true)
        
        // Move to top-left just below the rounded corner
        path.addLine(to: CGPoint(x: leadingPadding, y: cornerRadius))
        
        // Add top-left rounded corner
        path.addArc(withCenter: CGPoint(x: leadingPadding + cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        
        path.close()
        
        return path.cgPath
    }



    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let buttonRadius: CGFloat = 35
        return abs(self.center.x - point.x) > buttonRadius || abs(point.y) > buttonRadius
    }
}

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}
