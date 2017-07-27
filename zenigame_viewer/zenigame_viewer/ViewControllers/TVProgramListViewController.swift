//
//  TVProgramListViewController.swift
//  zenigame_viewer
//
//  Created by Kaoru Tsutsumishita on 2017/04/21.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import Alamofire
import ObjectMapper
import OHHTTPStubs
import UIKit

class TVProgramListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    fileprivate var tvPrograms = [TVProgram]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.black

        title = "番組表"

        tableView.dataSource = self
        tableView.delegate = self
        let cellNib = UINib(nibName: TVProgramTableViewCell.kCellId, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TVProgramTableViewCell.kCellId)
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

extension TVProgramListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvPrograms.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 10, y: 0, width: tableView.bounds.size.width, height: 40)
        let headerView = UIView(frame: frame)
        headerView.backgroundColor = UIColor.white

        let titleLabel = UILabel()
        titleLabel.frame = frame
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = UIColor.black
        titleLabel.text = "日付"
        headerView.addSubview(titleLabel)

        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVProgramTableViewCell.kCellId, for: indexPath) as! TVProgramTableViewCell // swiftlint:disable:this force_cast
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.selectionStyle = .none

        let tvProgram = tvPrograms[indexPath.row]

        if let s = tvProgram.startAt, let time = s.convertTo(format: "M/d' 'HH:mm'~'") {
            cell.timeLabel.text = time
        }
        cell.nameLabel.text = "番組バナー"
        return cell
    }
}

extension TVProgramListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (0, 0): // 基本情報
            break
        case (0, 1): // SNS連携設定/解除
            break
        case (1, 0): // NGワード設定/変更
            break
        case (1, 1): // NGユーザー一覧
            break
        case (2, 0): // プッシュ通知設定
            break
        case (2, 1): // キャッシュのクリア
            break
        default:
            break
        }
    }
}
