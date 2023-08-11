//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-07.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Check user and direct to suitable path
        ASP.shared.manageUserDirection(window: window)
 
        //-----Testing -------
//            let storyboard = UIStoryboard(name: "Home", bundle: nil)
//                    let viewController = storyboard.instantiateViewController(withIdentifier: "SeeAllNewsVC") as! SeeAllNewsVC
//                    let navigationController = UINavigationController.init(rootViewController: viewController)
//                    self.window?.rootViewController = navigationController
        
        //-----Testing -------
        
        return true
    }
    
    func setAsRoot(_controller: UIViewController) {
        if window != nil {
            window?.rootViewController = _controller
        }
    }
}

