//
//  NewsTVCell.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

import UIKit
import SDWebImage



class NewsTVCell: UITableViewCell {

    @IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageBack.layer.cornerRadius =  10
    }
    
    
    func configCell(article:Article?){
        let url = article?.urlToImage ?? ""
        if let author =  article?.author  {
            self.authorLbl.text = author
        }
        self.title.text = article?.title ?? ""
        self.dateLbl.text = (article?.publishedAt ?? "").convertToDate(format: .dateformatDMY)
        print(url)
        self.imageBack.sd_setImage(with: URL(string:url), placeholderImage: UIImage(named: "placeholder_image"))
    }
    
}
