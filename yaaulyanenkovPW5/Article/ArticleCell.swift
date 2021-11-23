//
//  ArticleCell.swift
//  yaaulyanenkovPW5
//
//  Created by Ярослав Ульяненков on 21.11.2021.
//

import Foundation
import UIKit


class ArticleCell: UITableViewCell {
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentConfiguration = defaultContentConfiguration()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setContent(article: Article.Fetch.ArticleModel) {
        var content = self.defaultContentConfiguration()
        content.image = UIImage(named: "kitten")
        DispatchQueue.global().async {
            let image = self.loadImage(url: article.img?.url) ?? UIImage(named: "kitten")
            self.setImage(image: image)
        }
        content.text = article.title
        content.secondaryText = article.announce
        content.imageProperties.maximumSize = CGSize(width: 100, height: 66)
        contentConfiguration = content
    }
    
    private func loadImage(url: URL?) -> UIImage? {
        guard let url = url else {
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    private func setImage(image: UIImage?){
        DispatchQueue.main.async {
            self.imageView?.image = image
        }
    }
}
