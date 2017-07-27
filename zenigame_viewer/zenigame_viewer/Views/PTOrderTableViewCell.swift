//
//  PTOrderTableViewCell.swift
//  zenigame_viewer
//
//  Created by Thanh-Tam Le on 5/10/17.
//  Copyright © 2017 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

// swiftlint:disable private_outlet
class PTOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var channelView: UIView!

    let topBorderView = UIView()
    let leftBorderView = UIView()
    let bottomBorderView = UIView()

    var constraintAdded = false

    static let kCellId = "PTOrderTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        channelView.backgroundColor = UIColor.white

        topBorderView.backgroundColor = UIColor.black
        leftBorderView.backgroundColor = UIColor.black
        bottomBorderView.backgroundColor = UIColor.black

        channelView.addSubview(topBorderView)
        channelView.addSubview(leftBorderView)
        channelView.addSubview(bottomBorderView)

        setNeedsUpdateConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if !constraintAdded {
            constraintAdded = true

            topBorderView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
            topBorderView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            topBorderView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
            topBorderView.autoSetDimension(.height, toSize: 1)

            bottomBorderView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
            bottomBorderView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            bottomBorderView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
            bottomBorderView.autoSetDimension(.height, toSize: 1)

            leftBorderView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
            leftBorderView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            leftBorderView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
            leftBorderView.autoSetDimension(.width, toSize: 1)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
