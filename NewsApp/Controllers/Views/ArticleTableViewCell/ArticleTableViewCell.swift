//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by Igor Belobrov on 29.01.2021.
//

import UIKit
import SDWebImage

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    func configureNews(article:News) {
        newsTitle.text = article.title
        newsSource.text = article.sourceName
        newsAuthor.text = article.author
        newsDescription.text = article.specification
        newsImage.sd_setImage(with: article.imageUrl, placeholderImage: UIImage(named: "noImage") )
    }
}
