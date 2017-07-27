//
//  UIImageView+FetchExtensions.swift
//  zenigame_viewer
//
//  Created by Kaoru Tsutsumishita on 2017/06/02.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setImage(with imageURLString: String?) {
        image = nil
        if let s = imageURLString, let url = URL(string: s) {
            let resource = ImageResource(downloadURL: url, cacheKey: s)
            kf.setImage(with: resource,
                        placeholder: UIImage(color: .groupTableViewBackground),
                        options: [.transition(.fade(0.2))],
                        progressBlock: nil) { (image, error, cacheType, _) in
                            if let e = error {
                                print("\(e.localizedDescription)")
                                return
                            }

                            if let i = image, cacheType == .none {
                                ImageCache.default.store(i, forKey: s)
                            }
            }
        } else {
            image = UIImage(color: .groupTableViewBackground)
        }
    }

}
