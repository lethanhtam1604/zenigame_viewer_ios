//
//  FavoritesViewController.swift
//  zenigame_viewer
//
//  Created by Kaoru Tsutsumishita on 2017/04/22.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import Alamofire
import ObjectMapper
import OHHTTPStubs
import UIKit

final class FavoritesViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var officialBtn: UIButton!
    @IBOutlet private weak var userBtn: UIButton!

    fileprivate var channels = [Channel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let cellNib = UINib(nibName: FavoritesTableViewCell.kCellId, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: FavoritesTableViewCell.kCellId)

        officialBtn.setBackgroundImage(UIImage(color: .clear), for: .normal)
        officialBtn.setBackgroundImage(UIImage(color: .blue), for: .selected)
        userBtn.setBackgroundImage(UIImage(color: .clear), for: .normal)
        userBtn.setBackgroundImage(UIImage(color: .blue), for: .selected)

        tableView.allowsSelectionDuringEditing = true
        tableView.isEditing = true
        officialBtn.isSelected = true
        userBtn.isSelected = false
        fetchFavoriteChannelBy(userId: 1234567890)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actionTapOfficialBtn(_ sender: Any) {
        officialBtn.isSelected = true
        userBtn.isSelected = false
        fetchFavoriteChannelBy(userId: 1234567890)
    }

    @IBAction func actionTapUserBtn(_ sender: Any) {
        officialBtn.isSelected = false
        userBtn.isSelected = true
        fetchFavoriteChannelBy(userId: 1234567890)
    }

    func actionFavoriteBtn(_ sender: UIButton) {
        channels.remove(at: sender.tag)
        tableView.reloadData()
    }

    private func fetchFavoriteChannelBy(userId: Int) {
        stub(condition: isHost(Router.host) && isPath(Router.getFavoriteChannel(userId).path)) { _ in
            return OHHTTPStubsResponse(
                // swiftlint:disable:next force_unwrapping
                fileAtPath: OHPathForFile("channels.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        }

        Alamofire.request(Router.getFavoriteChannel(userId))
            .responseJSON(completionHandler: { [weak self] response in
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                if let data = response.result.value as? [String: Any], let channels = Mapper<Channel>().mapArray(JSONObject: data["channels"]) {
                    self?.channels = channels
                    self?.tableView.reloadData()
                }
            })
    }

}

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FavoritesTableViewCell.kCellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoritesTableViewCell.kCellId,
            for: indexPath) as! FavoritesTableViewCell // swiftlint:disable:this force_cast
        let channel = channels[indexPath.row]
        cell.bannerImageView.setImage(with: channel.thumbnailUrl)
        cell.favoriteBtn.tag = indexPath.row
        cell.favoriteBtn.addTarget(self, action: #selector(actionFavoriteBtn(_:)), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }

}

extension FavoritesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let source = channels[sourceIndexPath.row]
        channels.remove(at: sourceIndexPath.row)
        channels.insert(source, at: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

}
