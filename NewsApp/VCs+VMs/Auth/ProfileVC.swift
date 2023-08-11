//
//  ProfileVC.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-11.
//

import UIKit

class ProfileVC: BaseVC {
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar(isHide: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideNavigationBar(isHide: false)
    }
    
    
    @IBAction func logoutTap(_ sender: Any) {
        PersistenceController.shared.logoutUser()
        ASP.shared.pushToViewController(in: .Auth, for: .LoginVC, from: self)
    }
}
