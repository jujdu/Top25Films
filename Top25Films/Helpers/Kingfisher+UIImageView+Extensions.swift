//
//  Kingfisher+UIImageView+Extensions.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 29.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(imageUrl: URL?) {
        self.kf.indicatorType = .activity
        let placeholder = UIImage(named: AppImages.placeholder)
        let options: KingfisherOptionsInfo = [.transition(.fade(0.2))]
        self.kf.setImage(with: imageUrl, placeholder: placeholder, options: options)
    }
}
