//
//  UIImage+ColorExtensions.swift
//  zenigame_viewer
//
//  Created by Kaoru Tsutsumishita on 2017/05/11.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

extension UIImage {

    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }

}
