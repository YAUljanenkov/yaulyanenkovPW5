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
    
    func setContent(id: Int) {
        var content = self.defaultContentConfiguration()
//        content.image = UIImage(systemName: "star")
        content.text = "Article \(id)"
//        content.imageProperties.tintColor = .purple
        contentConfiguration = content
    }
}
