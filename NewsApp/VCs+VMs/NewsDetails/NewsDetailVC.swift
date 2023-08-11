//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-11.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage



class NewsDetailVC: BaseVC {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var publishedByLbl: UILabel!
    @IBOutlet weak var descrtioinLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    var viewModel = NewsDetailViewModel()
    let disposeBag = DisposeBag()  // Dispose bag for RxSwift

    override func viewDidLoad() {
        super.viewDidLoad()

        defaultBackBtn()
        setData()
        // Do any additional setup after loading the view.
    }
    
    
    func setData() {
        // Bind article data from viewModel to UI components
        viewModel.article.subscribe(onNext: { [weak self] article in
            
            guard let strongSelf = self, let articleData = article else { return }
            strongSelf.dateLbl.text = articleData.publishedAt
            strongSelf.titleLbl.text = articleData.title
            strongSelf.descrtioinLbl.text = articleData.description
            strongSelf.publishedByLbl.text = articleData.author
                
            // Assuming you have a function to load image from URL
            
            strongSelf.imageView.sd_setImage(with: URL(string:articleData.urlToImage ?? ""), placeholderImage: UIImage(named: "placeholder_image"))
        }).disposed(by: disposeBag)
    }

}
