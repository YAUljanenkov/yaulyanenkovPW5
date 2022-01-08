//
//  ArticleCell.swift
//  yaaulyanenkovPW5
//
//  Created by Ярослав Ульяненков on 21.11.2021.
//

import Foundation
import UIKit


class ArticleCell: UITableViewCell {
    
    var loadedImage:  UIImageView = {
        let shimmerView = ShimmerView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        shimmerView.startAnimating()
        shimmerView.contentMode = .scaleAspectFit
        return shimmerView
    }()
    
    var title: String?
    var announce: String?
    var url: URL?
    var minHeight: CGFloat? = 100
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loadedImage.startAnimating()
        contentConfiguration = defaultContentConfiguration()
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        guard let minHeight = minHeight else { return size }
        return CGSize(width: size.width, height: max(size.height, minHeight))
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = self.defaultContentConfiguration().updated(for: state)
        content.text = title
        content.secondaryText = announce
        self.contentConfiguration = content
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0))
    }
    
    func setContent(article: Article.Fetch.ArticleModel) {
        title = article.title
        announce = article.announce
        url = article.articleUrl
        DispatchQueue.global().async {
            let image = self.loadImage(url: article.img?.url)
            DispatchQueue.main.async {
                self.loadedImage.stopAnimating()
                self.loadedImage.image = image
            }
        }
        setNeedsUpdateConfiguration()
        self.addSubview(loadedImage)
        self.sizeToFit()
        loadedImage.pinTop(to: self, 16)
        loadedImage.pinLeft(to: self, 8)
    }
    
    private func loadImage(url: URL?) -> UIImage? {
        guard let url = url else {
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)?.scalePreservingAspectRatio(targetSize: CGSize(width: 100, height: 100))
    }
}


extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}
