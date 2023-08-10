//
//  LatestNewsCell.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

import UIKit
import SDWebImage

class LatestNewsCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authotLbl: UILabel!
    @IBOutlet weak var contetntLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.cornerRadius =  20
    }
    func configCell(article:Article?){
        let url = article?.urlToImage ?? ""
        if let author =  article?.author  {
            self.authotLbl.text = "by" + author
        }
        self.titleLbl.text = article?.title ?? ""
        self.contetntLbl.text = article?.content ?? ""
        print(url)
        self.imageView.sd_setImage(with: URL(string:url), placeholderImage: UIImage(named: "placeholder_image"))
    }
}

extension UIImage {
    
    func blend(with color: UIColor, blendMode: CGBlendMode = .multiply) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: self.size)
        
        return renderer.image { context in
            // Draw the original image
            self.draw(at: .zero)

            // Set the blend mode and color
            context.cgContext.setBlendMode(blendMode)
            color.setFill()
            context.cgContext.fill(CGRect(origin: .zero, size: self.size))
        }
    }
}

