//
//  RankingViewController.swift
//  zenigame_viewer
//
//  Created by Kaoru Tsutsumishita on 2017/04/21.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import Alamofire
import ObjectMapper
import OHHTTPStubs
import UIKit

class RankingViewController: BaseViewController {

    @IBOutlet private weak var numberOfViewerBtn: UIButton!
    @IBOutlet private weak var numberOfRegistrationBtn: UIButton!
    @IBOutlet private weak var ptOrderBtn: UIButton!
    @IBOutlet private weak var tableView: UITableView!

    fileprivate var tvPrograms = [TVProgram]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.black

        title = "番組表"

        numberOfViewerBtn.layer.borderColor = UIColor.black.cgColor
        numberOfViewerBtn.layer.borderWidth = 1

        numberOfRegistrationBtn.layer.borderColor = UIColor.black.cgColor
        numberOfRegistrationBtn.layer.borderWidth = 1

        ptOrderBtn.layer.borderColor = UIColor.black.cgColor
        ptOrderBtn.layer.borderWidth = 1

        tableView.dataSource = self
        tableView.delegate = self
        let cellNib = UINib(nibName: PTOrderTableViewCell.kCellId, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: PTOrderTableViewCell.kCellId)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white

        fetchTVPrograms()
    }

    private func fetchTVPrograms() {
        stub(condition: isHost(Router.host) && isPath(Router.getTVProgram().path)) { _ in
            return OHHTTPStubsResponse(
                // swiftlint:disable:next force_unwrapping
                fileAtPath: OHPathForFile("programs.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        }

        Alamofire.request(Router.getTVProgram())
            .responseJSON(completionHandler: { [weak self] response in
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                if let data = response.result.value as? [String: Any], let tvPrograms = Mapper<TVProgram>().mapArray(JSONObject: data["programs"]) {
                    self?.tvPrograms = tvPrograms
                    self?.tableView.reloadData()
                }
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RankingViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvPrograms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PTOrderTableViewCell.kCellId, for: indexPath) as! PTOrderTableViewCell // swiftlint:disable:this force_cast

        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.selectionStyle = .none

        let tvProgram = tvPrograms[indexPath.row]

        cell.idLabel.text = String(tvProgram.ptCount) + "位"
        cell.nameLabel.text = "番組バナー"

        return cell
    }
}

extension RankingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
}
