//
//  ChannelCollectionViewFlowLayout.swift
//  zenigame_viewer
//
//  Created by 笹野駿 on 2017/05/31.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

class ChannelCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let x = collectionView?.contentOffset.x else {
            return CGPoint(x: 0, y: 0)
        }
        let currentPage = x / pageWidth()
        if fabs(velocity.x) > 0.2 {
            let nextPage: CGFloat = CGFloat((velocity.x > 0.0) ? ceil(currentPage) : floor(currentPage))
            return CGPoint(x: CGFloat((nextPage * pageWidth())), y: CGFloat(proposedContentOffset.y))
        } else {
            return CGPoint(x: CGFloat((round(currentPage) * pageWidth())), y: CGFloat(proposedContentOffset.y))
        }
    }

    func pageWidth() -> CGFloat {
        return itemSize.width + minimumLineSpacing
    }

}
