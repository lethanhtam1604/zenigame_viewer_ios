//
//  Utils.swift
//  zenigame_viewer
//
//  Created by Thanh-Tam Le on 5/15/17.
//  Copyright © 2017 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

class Utils {

    static func showAlert(title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
