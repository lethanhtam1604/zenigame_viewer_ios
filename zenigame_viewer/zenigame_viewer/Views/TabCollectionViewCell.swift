//
//  TabCollectionViewCell.swift
//  zenigame_viewer
//
//  Created by 笹野駿 on 2017/05/11.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

// swiftlint:disable private_outlet
class TabCollectionViewCell: UICollectionViewCell {

    var tabName = UILabel()

    static let kCell = "tabCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        tabName.textAlignment = .center
        tabName.sizeToFit()
        self.contentView.addSubview(tabName)
    }

    override func updateConstraints() {
        tabName.autoPinEdgesToSuperviewEdges()
        super.updateConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
