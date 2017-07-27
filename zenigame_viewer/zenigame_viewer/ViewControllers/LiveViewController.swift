//
//  LiveViewController.swift
//  zenigame_viewer
//
//  Created by 笹野駿 on 2017/05/30.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController {

    @IBOutlet fileprivate weak var channelCollectionView: UICollectionView!
    @IBOutlet fileprivate weak var pageControl: UIPageControl!
    @IBOutlet fileprivate weak var tvProgramCollectionView: UICollectionView!
    let banners = ["バナー1",
                   "バナー2",
                   "バナー3",
                   "バナー4",
                   "バナー5",
                   "バナー6"]

    let sectionTitles = ["LIVE配信", "現在開催中のイベント", "人気配信者の番組", "ガチャ"]

    enum SectionTitle: Int {
        case live = 0
        case holding
        case popular
        case gatya
    }

    var tvPrograms = [TVProgram]()
    let flowLayout = ChannelCollectionViewFlowLayout()
    var indicatorIndex = IndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 0...10 {
            let tvprogram = TVProgram()
            tvPrograms.append(tvprogram)
        }

        channelCollectionView.dataSource = self
        channelCollectionView.delegate = self
        channelCollectionView.register(UINib(nibName: "ChannelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ChannelCollectionViewCell.kCell)
        channelCollectionView.showsHorizontalScrollIndicator = false

        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: view.frame.size.width - 40, height: channelCollectionView.frame.size.height)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        flowLayout.minimumInteritemSpacing = 10
        channelCollectionView.collectionViewLayout = flowLayout

        pageControl.numberOfPages = banners.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.cyan

        tvProgramCollectionView.delegate = self
        tvProgramCollectionView.dataSource = self
        tvProgramCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TVProgramCollectionViewCell")

        let tvProgramCollectionViewCellFlowLayout = UICollectionViewFlowLayout()
        tvProgramCollectionViewCellFlowLayout.itemSize = CGSize(width: view.frame.size.width / 3 - 20, height: view.frame.size.width / 3 - 20)
        tvProgramCollectionView.collectionViewLayout = tvProgramCollectionViewCellFlowLayout

        tvProgramCollectionView.register(UINib(nibName: "TVProgramCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "TVProgramCollectionReusableView")
        tvProgramCollectionView.isScrollEnabled = false
        tvProgramCollectionView.frame.size.height = CGFloat(Int(tvProgramCollectionViewCellFlowLayout.itemSize.height) * 5 + 50 * 5)
        view.frame.size.height = CGFloat(view.frame.size.height) + CGFloat(Int(tvProgramCollectionViewCellFlowLayout.itemSize.height) * 5 + 50 * 5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actionNext(_ sender: Any) {
        moveCell(goNext: true)
    }
    @IBAction func actionBack(_ sender: Any) {
        moveCell(goNext: false)
    }

    func moveCell(goNext: Bool) {
        let cells = channelCollectionView.visibleCells
        for cell in cells {
            if channelCollectionView.bounds.contains(cell.frame) {
                guard let indicatorIndex = (channelCollectionView.indexPath(for: cell)) else {
                    return
                }
                self.indicatorIndex = indicatorIndex
                if indicatorIndex.row == 0 {
                    guard goNext == true else {
                        return
                    }
                }
                var goNum: Int
                if goNext == true {
                    if CGFloat(banners.count - 1) * (flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing) == channelCollectionView.contentOffset.x {
                        return
                    }
                    goNum = 1
                } else {
                    goNum = -1
                }
                channelCollectionView.setContentOffset(CGPoint(x: CGFloat(indicatorIndex.row + goNum) * (flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing), y: 0), animated: true)
            }
        }
    }

    @IBAction func actionTapToDeliveryButton(_ sender: Any) {
        let viewControlelr = DeliveryViewController.instantiate(storyboard: "Delivery")
        present(viewControlelr, animated: true, completion: nil)
    }

    @IBAction func actionTapToTVProgramButton(_ sender: Any) {
        let viewControlelr = TVProgramViewController.instantiate(storyboard: "TVProgram")
        present(viewControlelr, animated: true, completion: nil)
    }

    @IBAction func actionTapToTVProgramListButton(_ sender: Any) {
        let viewControlelr = TVProgramListViewController.instantiate(storyboard: "TVProgramList")
        let nav = UINavigationController(rootViewController: viewControlelr)
        present(nav, animated: true, completion: nil)
    }

    @IBAction func actionTapToDeliveriedTVProgramButton(_ sender: Any) {
        let viewControlelr = DeliveriedTVProgramViewController.instantiate(storyboard: "DeliveriedTVProgram")
        present(viewControlelr, animated: true, completion: nil)
    }

    @IBAction func actionTapToRankingButton(_ sender: Any) {
        let viewControlelr = RankingViewController.instantiate(storyboard: "Ranking")
        let nav = UINavigationController(rootViewController: viewControlelr)
        present(nav, animated: true, completion: nil)
    }

    @IBAction func actionTapToGachaButton(_ sender: Any) {
        let viewControlelr = GachaViewController.instantiate(storyboard: "Gacha")
        present(viewControlelr, animated: true, completion: nil)
    }

    @IBAction func actionTapToFooterButton(_ sender: Any) {
        let viewControlelr = FooterViewController.instantiate(storyboard: "Footer")
        present(viewControlelr, animated: true, completion: nil)
    }

}

extension LiveViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == channelCollectionView {
            return 1
        } else {
            return 4
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == channelCollectionView {
        return CGSize(width: 0, height: 0)
        } else {
            return CGSize(width: view.frame.size.width, height: 50)
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch collectionView {
        case channelCollectionView:
            return UICollectionReusableView()
        case tvProgramCollectionView:
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "TVProgramCollectionReusableView", for: indexPath) as! TVProgramCollectionReusableView // swiftlint:disable:this force_cast
            sectionHeader.titleLabel.text = sectionTitles[indexPath.section]
            sectionHeader.titleLabel.sizeToFit()
            sectionHeader.updateConstraintsIfNeeded()
            return sectionHeader
        default:
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == channelCollectionView {
            return banners.count
        } else {
            if let sectionTitle: SectionTitle = SectionTitle(rawValue: section) {
                switch sectionTitle {
                case .live:
                    return 4
                case .holding:
                    return 2
                case .popular:
                    return 3
                case .gatya:
                    return 2
                }
            } else {
                return 0
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        switch collectionView {
        case channelCollectionView:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCollectionViewCell.kCell, for: indexPath) as! ChannelCollectionViewCell // swiftlint:disable:this force_cast
            cell.layer.borderWidth = 3
            cell.layer.borderColor = UIColor.black.cgColor
        case tvProgramCollectionView:
            let program = tvPrograms[indexPath.row]
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVProgramCollectionViewCell", for: indexPath)
            cell.backgroundColor = UIColor.red
        default:
            break
        }
        return cell
    }

}

extension LiveViewController: UICollectionViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let cells = channelCollectionView.visibleCells
        for cell in cells {
            if channelCollectionView.bounds.contains(cell.frame) {
                if let indicatorIndex = (channelCollectionView.indexPath(for: cell)) {
                    pageControl.currentPage = indicatorIndex.row
                }
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let cells = channelCollectionView.visibleCells
        for cell in cells {
            if channelCollectionView.bounds.contains(cell.frame) {
                if let indicatorIndex = (channelCollectionView.indexPath(for: cell)) {
                    pageControl.currentPage = indicatorIndex.row
                }
            }
        }
    }

}

extension LiveViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 0, height: 0)
        switch collectionView {
        case channelCollectionView:
            size = CGSize(width: view.frame.size.width - 40, height: channelCollectionView.frame.size.height)
        case tvProgramCollectionView:
            if let sectionTitle = SectionTitle(rawValue: indexPath.section) {
                switch sectionTitle {
                case .popular:
                    collectionView.collectionViewLayout = collectionViewLayout
                    size = CGSize(width: view.frame.size.width / 3 - 20, height: view.frame.size.width / 3 - 20)
                case .gatya:
                    size = CGSize(width: view.frame.size.width - 20, height: view.frame.size.width / 3 - 20)
                default:
                    size = CGSize(width: view.frame.size.width / 2 - 20, height: view.frame.size.width / 2 - 20)
                }
            }
        default:
            break
        }
        return size
    }
}
