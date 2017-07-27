//
//  EventCollectionReusableView.swift
//  zenigame_viewer
//
//  Created by 笹野駿 on 2017/06/12.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

class EventCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    static let kCell = "EventCollectionReusableView"
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func updateConstraints() {
        titleLabel.sizeToFit()
        titleLabel.autoSetDimension(.height, toSize: titleLabel.frame.size.height)
        titleLabel.autoSetDimension(.width, toSize: titleLabel.frame.size.width)
        titleLabel.autoPinEdge(toSuperviewEdge: .bottom)
        titleLabel.autoPinEdge(toSuperviewEdge: .left)
        super.updateConstraints()
    }
}
