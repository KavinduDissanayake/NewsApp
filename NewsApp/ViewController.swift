//
//  ViewController.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-07.
//

import UIKit

class ViewController: UIViewController {

   
    let contentView = UIView()
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let floatingTabbar = FloatingTabbar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default view content
        updateView(for: 0)
        
        // FloatingTabbar action
        floatingTabbar.selectionChanged = { [weak self] index in
            self?.updateView(for: index)
        }
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .gray
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        floatingTabbar.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15

        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        view.addSubview(contentView)
        view.addSubview(floatingTabbar)
        
        NSLayoutConstraint.activate([
            // ContentView
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: floatingTabbar.topAnchor, constant: -20),
            
            // TitleLabel
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -150),
            
            // ImageView
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            // FloatingTabbar
            floatingTabbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            floatingTabbar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            floatingTabbar.widthAnchor.constraint(equalToConstant: 250),
            floatingTabbar.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func updateView(for index: Int) {
        switch index {
        case 0:
            titleLabel.text = "Home"
            imageView.image = UIImage(named: "1")
        case 1:
            titleLabel.text = "Wishlist"
            imageView.image = UIImage(named: "2")
        default:
            titleLabel.text = "Cart"
            imageView.image = UIImage(named: "3")
        }
    }

    func createTopBar() -> UIView {
        let topBar = UIView()
        topBar.backgroundColor = .red
        topBar.translatesAutoresizingMaskIntoConstraints = false

        // Adding a simple label as an example
        let label = UILabel()
        label.text = "14:42"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.0)

        topBar.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: topBar.centerXAnchor)
        ])

        return topBar
    }
}


class FloatingTabbar: UIView {
    
    var selectionChanged: ((Int) -> Void)?
    
    // Use UIButton for house, heart, and cart
    let homeButton = UIButton(type: .system)
    let wishlistButton = UIButton(type: .system)
    let cartButton = UIButton(type: .system)
    
    var isExpanded = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.layer.cornerRadius = 20
        self.backgroundColor = .white
        
        homeButton.setImage(UIImage(systemName: "house"), for: .normal)
        wishlistButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
        
        let stackView = UIStackView(arrangedSubviews: [homeButton, wishlistButton, cartButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        self.addGestureRecognizer(longPressGesture)
    }


    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            isExpanded.toggle()
            // Handle UI changes or animations related to the expand/collapse action
        }
    }

    
    @objc func handleHomeButton() {
        selectionChanged?(0)
    }
    
    @objc func handleWishlistButton() {
        selectionChanged?(1)
    }
    
    @objc func handleCartButton() {
        selectionChanged?(2)
    }
    
    // Similarly, add long press gesture to handle expansion.
}
