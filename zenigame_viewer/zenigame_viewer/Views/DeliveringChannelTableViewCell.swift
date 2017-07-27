//
//  DeliveringChannelTableViewCell.swift
//  zenigame_viewer
//
//  Created by 笹野駿 on 2017/05/13.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

// swiftlint:disable private_outlet
class DeliveringChannelTableViewCell: UITableViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!

    static let kCellId = "DeliveringChannelTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
