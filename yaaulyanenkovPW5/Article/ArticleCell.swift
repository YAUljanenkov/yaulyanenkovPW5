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
    
    private func loadImage(url: URL?) -> UIImage? {
        guard let url = url else {
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    var loadedImage: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.setNeedsUpdateConfiguration()
            }
        }
    }
    
    var title: String?
    var announce: String?
    var url: URL?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = self.defaultContentConfiguration().updated(for: state)
        content.text = title
        content.secondaryText = announce
        content.image = self.loadedImage
        content.imageProperties.reservedLayoutSize = CGSize(width: 120, height: 100)
        content.imageProperties.maximumSize = CGSize(width: 120, height: 100)
        self.contentConfiguration = content
    }
    
    func setContent(article: Article.Fetch.ArticleModel) {
        title = article.title
        announce = article.announce
        loadedImage = UIImage(named: "kitten")
        url = article.articleUrl
        DispatchQueue.global().async {
            self.loadedImage = self.loadImage(url: article.img?.url)
        }
        setNeedsUpdateConfiguration()
    }
    
    
}
