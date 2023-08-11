//
//  ASP+Navigations+Present.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-11.
//

import UIKit



extension ApplicationServiceProvider {
    public func presentViewController(in sb: Storyboard, for identifier: ViewContolers, from vc: UIViewController?, delegate: FilterBottomSheetVCDelegate? = nil, style: UIModalPresentationStyle = .overCurrentContext, data: Any? = nil, data2: Any? = nil) {
        
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        
        switch identifier {
        case .FilterBottomSheetVC:
            if let destVc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue) as? FilterBottomSheetVC {
                destVc.delegate = delegate
                destVc.modalPresentationStyle = style
                vc?.present(destVc, animated: true, completion: nil)
            }
            
        // Handle other cases as before...
        default:
            let destVc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
            destVc.modalPresentationStyle = style
            vc?.present(destVc, animated: true, completion: nil)
        }
    }

}
