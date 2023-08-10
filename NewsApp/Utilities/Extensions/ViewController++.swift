//
//  ViewController++.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-09.
//

import UIKit

struct viewGlobal{
    static var bottomConstraint : NSLayoutConstraint = NSLayoutConstraint()
}

extension UIViewController{ //keyboardHandler
 func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
 }
 func listenerKeyboard(bottomConstraint: NSLayoutConstraint) {
    viewGlobal.bottomConstraint = bottomConstraint
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    // Register your Notification, To know When Key Board Hides.
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
 }
 //Dismiss Keyboard
 @objc func dismissKeyboard() {
    view.endEditing(true)
 }
 @objc func keyboardWillShow(notification:NSNotification) {
    let userInfo:NSDictionary = notification.userInfo! as NSDictionary
    let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
    let keyboardRectangle = keyboardFrame.cgRectValue
    let keyboardHeight = keyboardRectangle.height
    UIView.animate(withDuration: 0.5){
        viewGlobal.bottomConstraint.constant = keyboardHeight
    }
 }

 @objc func keyboardWillHide(notification:NSNotification) {
    UIView.animate(withDuration: 0.5){
        viewGlobal.bottomConstraint.constant = 0
    }
 }
}
