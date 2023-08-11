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
        
//        if let isLoagin = PersistenceController.shared.loggedIn,isLoagin {
//            print("User with email  is logged in!")
//            let storyboard = UIStoryboard(name: "BottomTabBar", bundle: nil)
//            let viewController = storyboard.instantiateViewController(withIdentifier: "CustomTBC") as! CustomTBC
//            let navigationController = UINavigationController.init(rootViewController: viewController)
//            self.window?.rootViewController = navigationController
//        } else {
//            print("No user is currently logged in.")
//            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
//            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//            let navigationController = UINavigationController.init(rootViewController: viewController)
//            self.window?.rootViewController = navigationController
        //   }
        
    
//    let storyboard = UIStoryboard(name: "BottomTabBar", bundle: nil)
//    let viewController = storyboard.instantiateViewController(withIdentifier: "SeeAllNewsVC") as!
//    let navigationController = UINavigationController.init(rootViewController: viewController)
////        viewController.viewModel.article.accept(dummyArticle1)
//    self.window?.rootViewController = navigationController
        
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    let navigationController = UINavigationController.init(rootViewController: viewController)
                    self.window?.rootViewController = navigationController
        
        return true
    }
    
}

