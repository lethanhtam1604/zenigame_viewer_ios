//
//  TVProgramCollectionReusableView.swift
//  zenigame_viewer
//
//  Created by 笹野駿 on 2017/06/08.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

class TVProgramCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreLabel: UILabel!

    override func updateConstraints() {

        moreLabel.sizeToFit()
        moreLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        moreLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        moreLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        moreLabel.autoSetDimension(.width, toSize: moreLabel.frame.size.width)

        titleLabel.sizeToFit()
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        titleLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        titleLabel.autoPinEdge(.right, to: .left, of: moreLabel)
        super.updateConstraints()

    }
}
