//
//  StoryBoard+UIViewControllerExtensions.swift
//  zenigame_viewer
//
//  Created by Kaoru Tsutsumishita on 2017/04/21.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

protocol UIViewControllerExtensions {
}

extension UIViewControllerExtensions where Self: UIViewController {

    static func instantiate() -> Self {
        return self.instantiate(storyboard: self.className)
    }

    static func instantiate(storyboard: String) -> Self {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        // swiftlint:disable:next force_cast
        return storyboard.instantiateViewController(withIdentifier: self.className) as! Self
    }

}

extension UIViewController: UIViewControllerExtensions {

    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }

}
