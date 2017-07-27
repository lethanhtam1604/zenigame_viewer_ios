//
//  EventViewController.swift
//  zenigame_viewer
//
//  Created by 笹野駿 on 2017/06/12.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

class EventViewController: BaseViewController {

    @IBOutlet fileprivate weak var eventCollectionView: UICollectionView!

    let sectionTitles = ["開催中", "近日開催", "終了済み"]

    override func viewDidLoad() {
        super.viewDidLoad()
        eventCollectionView.dataSource = self
        eventCollectionView.delegate = self
        eventCollectionView.register(UINib(nibName: EventCollectionViewCell.kCell, bundle: nil), forCellWithReuseIdentifier: EventCollectionViewCell.kCell)
        eventCollectionView.register(UINib(nibName: EventCollectionReusableView.kCell, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: EventCollectionReusableView.kCell)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: view.frame.size.width / 2 - 40, height: view.frame.size.width / 2 - 40)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        eventCollectionView.collectionViewLayout = flowLayout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension EventViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.kCell, for: indexPath)
        cell.backgroundColor = UIColor.red
        cell.updateConstraintsIfNeeded()
        return cell
    }
}

extension EventViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 100)

    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: EventCollectionReusableView.kCell, for: indexPath) as! EventCollectionReusableView //swiftlint:disable:this force_cast

        sectionHeader.titleLabel.text = sectionTitles[indexPath.section]
        sectionHeader.titleLabel.sizeToFit()
          return sectionHeader
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "EventDetail", bundle: nil)
        if let eventDetailVC = storyboard.instantiateViewController(withIdentifier: "EventDetailViewController") as? EventDetailViewController {
            self.navigationController?.pushViewController(eventDetailVC, animated: true)
        }
    }

}
