//
//  HomeVC.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

import UIKit
import SwiftUI


class HomeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.latestNewsCV {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestNewsCell", for: indexPath) as? LatestNewsCell else {
                return UICollectionViewCell()
            }
            
            return cell
        }
        
        if collectionView == self.catgoryCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {
                return UICollectionViewCell()
            }
            
            return cell
        }
        
        
        return UICollectionViewCell()
    }
    

    
    @IBOutlet weak var latestNewsCV: UICollectionView!
    @IBOutlet weak var catgoryCV: UICollectionView!
    @IBOutlet weak var allNewsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.latestNewsCV.register(UINib(nibName: "LatestNewsCell", bundle: Bundle.main), forCellWithReuseIdentifier: "LatestNewsCell")
        self.latestNewsCV.delegate = self
        self.latestNewsCV.dataSource = self
        
        self.catgoryCV.register(UINib(nibName: "CategoryCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CategoryCell")
        self.catgoryCV.delegate = self
        self.catgoryCV.dataSource = self
        
        
        self.allNewsTV.register(UINib(nibName: "NewsTVCell", bundle: nil), forCellReuseIdentifier: "NewsTVCell")
        self.allNewsTV.delegate = self
        self.allNewsTV.dataSource = self

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: - Navigation
extension HomeVC:UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTVCell", for: indexPath) as? NewsTVCell else {
            return UITableViewCell()
        }
        return cell

    }
    
    
}


//MARK: PREVIEW
struct HomeVC_Previews: PreviewProvider {
    static var previews: some View {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? UIViewController else {
            fatalError("Cannot instantiate SampleTabBarController from Main.storyboard")
        }
        return UIViewControllerWrapper(viewController: homeVC).ignoresSafeArea()
    }
}

