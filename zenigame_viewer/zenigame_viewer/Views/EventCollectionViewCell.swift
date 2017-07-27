//
//  EventCollectionViewCell.swift
//  zenigame_viewer
//
//  Created by 笹野駿 on 2017/06/12.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var remainDaysLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    static let kCell = "EventCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func updateConstraints() {
        titleLabel.sizeToFit()
        titleLabel.autoSetDimension(.height, toSize: titleLabel.frame.size.height)
        titleLabel.autoSetDimension(.width, toSize: titleLabel.frame.size.width)
        titleLabel.autoPinEdge(toSuperviewEdge: .top)
        titleLabel.autoPinEdge(toSuperviewEdge: .left)

        periodLabel.sizeToFit()
        periodLabel.autoSetDimension(.height, toSize: periodLabel.frame.size.height)
        periodLabel.autoSetDimension(.width, toSize: periodLabel.frame.size.width)
        periodLabel.autoPinEdge(toSuperviewEdge: .bottom)
        periodLabel.autoPinEdge(toSuperviewEdge: .right)
        
        remainDaysLabel.sizeToFit()
        remainDaysLabel.autoSetDimension(.height, toSize: remainDaysLabel.frame.size.height)
        remainDaysLabel.autoSetDimension(.width, toSize: remainDaysLabel.frame.size.width)
        remainDaysLabel.autoPinEdge(toSuperviewEdge: .right)
        remainDaysLabel.autoPinEdge(.bottom, to: .top, of: periodLabel)

        bannerImageView.autoPinEdge(.top, to: .bottom, of: titleLabel)
        bannerImageView.autoPinEdge(toSuperviewEdge: .left)
        bannerImageView.autoPinEdge(.bottom, to: .top, of: periodLabel)
        bannerImageView.autoPinEdge(toSuperviewEdge: .right)

        super.updateConstraints()
    }

}
