//
//  BaseVC.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-07.
//

import UIKit
class BaseVC: UIViewController,LoadingIndicatorDelegate{
    // Back navigation
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func hideNavigationBar(isHide:Bool = true){
        self.navigationController?.isNavigationBarHidden = isHide
    }
    
    func handleError(_ errorMessage: String) {
        // Present an alert or handle the error in another way
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true)
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
