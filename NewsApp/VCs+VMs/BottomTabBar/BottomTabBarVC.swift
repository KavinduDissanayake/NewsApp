//
//  BottomTabBarVC.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-09.
//

import UIKit

class BottomTabBarVC: UIViewController {
    @IBOutlet weak var bottomTabBarCV: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bottomTabBarCV.register(UINib(nibName: "CustomTabitem", bundle: Bundle.main), forCellWithReuseIdentifier: "CustomTabitem")
        self.bottomTabBarCV.delegate = self
        self.bottomTabBarCV.dataSource = self
        self.bottomTabBarCV.isScrollEnabled = false
        self.bottomTabBarCV.layer.cornerRadius = 40
    }
}

extension BottomTabBarVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // let's assume that each row in the collection view should contains 3 cells:
        let desiredWidth = collectionView.frame.width / 3

        // height is also equals to the width to be a square...
        return CGSize(width: desiredWidth, height: desiredWidth)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomTabitem", for: indexPath) as? CustomTabitem else {
            print("Error: Unable to dequeue CustomTabitem")
            return UICollectionViewCell()
        }

        return cell
    }
}
