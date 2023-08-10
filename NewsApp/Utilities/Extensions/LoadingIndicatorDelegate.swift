//
//  LoadingIndicatorDelegate.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

import RappleProgressHUD

protocol LoadingIndicatorDelegate {
    func startLoading()
    func stopLoading()
}

extension LoadingIndicatorDelegate {
    // -------- RappleProgressHUD -------- //
    // Start loading
    func startLoading() {
        RappleActivityIndicatorView.startAnimating()
    }

    // Stop loading
    func stopLoading() {
        RappleActivityIndicatorView.stopAnimation()
    }

}


