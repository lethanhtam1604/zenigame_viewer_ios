//
//  DeliveriedTVProgramViewController.swift
//  zenigame_viewer
//
//  Created by Kaoru Tsutsumishita on 2017/04/21.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit
import PureLayout

class DeliveriedTVProgramViewController: BaseViewController {

    @IBOutlet fileprivate weak var channelTableView: UITableView!
    @IBOutlet private weak var tabCollectionView: UICollectionView!

    let tabNames = ["開始順",
                        "観客数",
                        "PT順"]
    var deliveringChannels = [DeliveringChannel]()
    var formatter = DateFormatter()
    let jaLocale = Locale(identifier: "ja_JP")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "現在配信中"
        tabCollectionView.register(UINib(nibName: "TabCollectionViewCell", bundle: nil),
                                   forCellWithReuseIdentifier: TabCollectionViewCell.kCell)
        let cellNib = UINib(nibName: DeliveringChannelTableViewCell.kCellId, bundle: nil)
        channelTableView.register(cellNib, forCellReuseIdentifier: DeliveringChannelTableViewCell.kCellId)
        tabCollectionView.dataSource = self
        tabCollectionView.delegate = self
        channelTableView.dataSource = self
        loadData()
    }

    func loadData() {

        var deliveringChannel = DeliveringChannel()
        formatter.locale = jaLocale
        formatter.dateFormat = "HH：mm"
        for i in 1...5 {
            deliveringChannel = DeliveringChannel()
            deliveringChannel.startDate = formatter.date(from: "12：2\(i)")
            deliveringChannel.audienceCount = i
            deliveringChannel.PT = i
            deliveringChannels.append(deliveringChannel)
        }
        channelTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func updateViewConstraints() {
        if let nav = self.navigationController {
            tabCollectionView.autoPinEdge(.top, to: .bottom, of: nav.navigationBar)
            tabCollectionView.autoPinEdge(toSuperviewEdge: .left)
            tabCollectionView.autoPinEdge(toSuperviewEdge: .right)
            tabCollectionView.autoSetDimension(.height, toSize: 50)
            channelTableView.autoPinEdge(.top, to: .bottom, of: tabCollectionView)
            channelTableView.autoPinEdge(.left, to: .left, of: view)
            channelTableView.autoPinEdge(.right, to: .right, of: view)
            channelTableView.autoPinEdge(.bottom, to: .bottom, of: view)
        }
        super.updateViewConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let tabCollectionViewFlowLayout = UICollectionViewFlowLayout()
        tabCollectionViewFlowLayout.scrollDirection = .horizontal
        tabCollectionViewFlowLayout.minimumLineSpacing = 0
        tabCollectionView.collectionViewLayout = tabCollectionViewFlowLayout
        tabCollectionView.showsHorizontalScrollIndicator = false
    }

}

extension DeliveriedTVProgramViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "tabCell", for: indexPath) as! TabCollectionViewCell // swiftlint:disable:this force_cast
        cell.tabName.text = tabNames[indexPath.row]
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.updateConstraints()
        return cell
    }
}

extension DeliveriedTVProgramViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            deliveringChannels.sort(by: {
                guard let s0 = $0.startDate, let s1 = $1.startDate else {
                    return true
                }
                return s0 < s1
            })
            channelTableView.reloadData()
        case 1:
            deliveringChannels.sort(by: {
                guard let a0 = $0.audienceCount, let a1 = $1.audienceCount else {
                    return true
                }
                return a0 > a1
            })
            channelTableView.reloadData()
        case 2:
            channelTableView.reloadData()
            deliveringChannels.sort(by: {
                guard let p0 = $0.PT, let p1 = $1.PT else {
                    return true
                }
                return p0 > p1
            })
        default:
            break
        }
    }
}

extension DeliveriedTVProgramViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3, height: collectionView.frame.size.width)
    }
}

extension DeliveriedTVProgramViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveringChannels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: DeliveringChannelTableViewCell.kCellId, for: indexPath) as! DeliveringChannelTableViewCell // swiftlint:disable:this force_cast
        formatter.locale = jaLocale
        formatter.dateFormat = "HH:mm"
        if let date = deliveringChannels[indexPath.row].startDate {
            cell.timeLabel.text = "\(formatter.string(from: date))〜"
        }
        return cell
    }
}
