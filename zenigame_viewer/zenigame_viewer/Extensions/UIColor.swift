//
//  UIColor.swift
//  zenigame_viewer
//
//  Created by Thanh-Tam Le on 5/19/17.
//  Copyright © 2017 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

extension UIColor {

    var coreImageColor: CoreImage.CIColor {
        return CoreImage.CIColor(color: self)
    }

    public convenience init(_ value: Int) {
        let components = getColorComponents(value: value)
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: 1.0)
    }
}

private func getColorComponents(value: Int) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
    let r = CGFloat(value >> 16 & 0xFF) / 255.0
    let g = CGFloat(value >> 8 & 0xFF) / 255.0
    let b = CGFloat(value & 0xFF) / 255.0

    return (r, g, b)
}
