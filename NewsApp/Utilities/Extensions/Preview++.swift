//
//  Preview++.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-09.
//

import SwiftUI
extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}


// MARK: - UIViewControllerPreview Struct
struct UIViewControllerWrapper<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController

    func makeUIViewController(context: Context) -> ViewController {
        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}

struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    private let configure: (ViewController) -> Void
    private let storyboard: UIStoryboard?
    private let identifier: String?
    
    init(storyboard: UIStoryboard, identifier: String, _ configure: @escaping (ViewController) -> Void = { _ in }) {
        self.storyboard = storyboard
        self.identifier = identifier
        self.configure = configure
    }
    
    init(_ configure: @escaping (ViewController) -> Void = { _ in }) {
        self.storyboard = nil
        self.identifier = nil
        self.configure = configure
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        if let storyboard = storyboard, let identifier = identifier {
            let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! ViewController
            configure(viewController)
            return viewController
        }
        let viewController = ViewController()
        configure(viewController)
        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}
