//
//  UIImageView+Kingfisher.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 08/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func set(_ urlString: String, withPlaceholder placeholder: String) {
        guard let url = URL(string: urlString) else { return }
        self.kf.setImage(
        with: url,
        placeholder: UIImage(named: "placeholder"),
        options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ])
    }
}
