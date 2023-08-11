//
//  ApplicationServiceProvider.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-11.
//

import UIKit

let ASP = ApplicationServiceProvider.self


enum ViewContolers: String {
    case LoginVC
    case SignUpVC
    case HomeVC
    case CustomTBC
    case NewsDetailVC
    case FilterBottomSheetVC
    
}

enum Storyboard: String {
    case Main
    case BottomTabBar
    case Auth
    case Home
}


class ApplicationServiceProvider {
    
    static let shared = ApplicationServiceProvider()
    
    public func pushToViewController(in sb: Storyboard, for identifier: ViewContolers, from vc: UIViewController?, data: Any? = nil) {
        
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        
        // Initialize based on the ViewContolers enum value
        switch identifier {
        case .LoginVC, .SignUpVC, .HomeVC, .FilterBottomSheetVC:
            let destVc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
            vc?.navigationController?.pushViewController(destVc, animated: true)
            
        case .CustomTBC: // Assuming you added this case to your enum
            if let _vc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue) as? CustomTBC {
                vc?.navigationController?.pushViewController(_vc, animated: true)
            }
        case .NewsDetailVC: // Assuming you added this case to your enum
            if let _vc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue) as? NewsDetailVC {
                if let dataRecived =  data as? Article {
                    _vc.viewModel.article.accept(dataRecived)
                }
                vc?.navigationController?.pushViewController(_vc, animated: true)
            }
        }}
}