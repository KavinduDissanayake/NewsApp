//
//   ASP+Navigations+Rooting.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-11.
//

import UIKit

extension ApplicationServiceProvider {
    
    //MARK: Manage User Direction
    public func manageUserDirection(from vc: UIViewController? = nil, window: UIWindow? = nil) {

        if let isLoagin = PersistenceController.shared.loggedIn,isLoagin {
            getRedirectionWithMainInterfaceType(type:.BottomTabBar, window: window)
        }else{
            getRedirectionWithMainInterfaceType(type:.Auth ,window: window)
        }
    }
    
    
    //MARK: Get ridirection with app main interface type
    func getRedirectionWithMainInterfaceType(type: MainInterfaceType, from vc: UIViewController? = nil, window: UIWindow? = nil) {
        switch type {
        case .Auth:
            directToPath(in: .Auth, for: .LoginVC, from: vc, window: window,wrapInNavigationController: true)
        case  .BottomTabBar:
            directToPath(in: .BottomTabBar, for: .CustomTBC, from: vc, window: window,wrapInNavigationController: true)
            break
        }
    }
    
    
    //MARK: Direct to Main Root window
    // MARK: Direct to Main Root window
    public func directToPath(in sb: Storyboard, for identifier: ViewContolers, from vc: UIViewController? = nil, window: UIWindow? = nil, wrapInNavigationController: Bool = false) {
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let topController = storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
        
        if wrapInNavigationController {
            let navigationController = UINavigationController.init(rootViewController: topController)
            appDelegate.setAsRoot(_controller: navigationController)
        } else {
            appDelegate.setAsRoot(_controller: topController)
        }
    }

    
    //MARK: Get ViewController (VC, TVC, CVC, PC, TBC etc.)
    public func viewController(in sb: Storyboard, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let targetVC = storyboard.instantiateViewController(withIdentifier: identifier)
        return targetVC
    }
    
}
