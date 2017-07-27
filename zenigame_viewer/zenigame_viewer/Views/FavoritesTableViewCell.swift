//
//  FavoritesTableViewCell.swift
//  zenigame_viewer
//
//  Created by Kaoru Tsutsumishita on 2017/05/10.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit
import Kingfisher

// swiftlint:disable private_outlet
class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var favoriteBtn: UIButton!

    static let kCellId = "FavoritesTableViewCell"
    static let kCellHeight = CGFloat(128)

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
