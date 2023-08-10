//
//  BaseVC.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-07.
//

import UIKit
class BaseVC: UIViewController{
    // Back navigation
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
//custom back item
extension BaseVC {
    
    func defaultBackBtn(){
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isHiddenHairline = true
        
        let newBackButton = UIBarButtonItem(image: UIImage(named: "ic_back")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.backToPrevouis(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        
    }
    
    @objc func backToPrevouis(sender: UIBarButtonItem) {
        self.goBack()
    }
    
}
