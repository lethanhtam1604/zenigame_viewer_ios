//
//  SlideMenuViewController.swift
//  zenigame_viewer
//
//  Created by 笹野駿 on 2017/04/25.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

class SlideMenuViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    let menuArray = ["ホーム",
                     "マイページ",
                     "公式番組一覧",
                     "配信中番組一覧",
                     "お気に入り",
                     "ランキング",
                     "バナコインチャージ",
                     "ヘルプ",
                     "設定",
                     "お問い合わせ",
                     "プライバシポリシー",
                     "利用規約",
                     "著作権表記",
                     "ログアウト"]

    enum Menu: Int {
        case home = 0
        case myPage
        case officialTv
        case deliveriedTVProgram
        case favorites
        case ranking
        case banaCoin
        case help
        case config
        case contact
        case privacy
        case agreement
        case copyright
        case logout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SlideMenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "slideMenuCell", for: indexPath)
        cell.textLabel?.text = menuArray[indexPath.row]
        return cell
    }
}

extension SlideMenuViewController: UITableViewDelegate {

//    func tableView(_ tableView: UITableView,
//                   didSelectRowAt indexPath: IndexPath) {
//        if let menu: Menu = Menu(rawValue: indexPath.row) {
//            switch menu {
//            case .home:
//                let storyboard = UIStoryboard(name: "Home", bundle: nil)
//                if let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
//                    let rootViewController = UINavigationController(rootViewController: viewController)
//                    self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
//                }
//            case .myPage:
//                let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
//                if let viewController = storyboard.instantiateViewController(withIdentifier:
//                    "MyPageViewController") as? MyPageViewController {
//                    let rootViewController = UINavigationController(rootViewController: viewController)
//                    self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
//                }
//            case .officialTv:
//                let storyboard = UIStoryboard(name: "OfficialTVProgram", bundle: nil)
//                if let viewController = storyboard.instantiateViewController(withIdentifier:
//                    "OfficialTVProgramViewController") as? OfficialTVProgramViewController {
//                    let rootViewController = UINavigationController(rootViewController: viewController)
//                    self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
//                }
//            case .deliveriedTVProgram:
//                let storyboard = UIStoryboard(name: "DeliveriedTVProgram", bundle: nil)
//                if let viewController = storyboard.instantiateViewController(withIdentifier:
//                    "DeliveriedTVProgramViewController") as? DeliveriedTVProgramViewController {
//                    let rootViewController = UINavigationController(rootViewController: viewController)
//                    self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
//                }
//            case .favorites:
//                let storyboard = UIStoryboard(name: "Favorites", bundle: nil)
//                if let viewController = storyboard.instantiateViewController(withIdentifier:
//                    "FavoritesViewController") as? FavoritesViewController {
//                    let rootViewController = UINavigationController(rootViewController: viewController)
//                    self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
//                }
//            case .ranking:
//                let storyboard = UIStoryboard(name: "Ranking", bundle: nil)
//                if let viewController = storyboard.instantiateViewController(withIdentifier:
//                    "RankingViewController") as? RankingViewController {
//                    let rootViewController = UINavigationController(rootViewController: viewController)
//                    self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
//                }
//            case .banaCoin:
//                let storyboard = UIStoryboard(name: "BanaCoinCharge", bundle: nil)
//                if let viewController = storyboard.instantiateViewController(withIdentifier:
//                    "BanaCoinChargeViewController") as? BanaCoinChargeViewController {
//                    let rootViewController = UINavigationController(rootViewController: viewController)
//                    self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
//                }
//            case .help:
//                let storyboard = UIStoryboard(name: "Help", bundle: nil)
//                if let viewController = storyboard.instantiateViewController(withIdentifier: "HelpViewController") as? HelpViewController {
//                    let rootViewController = UINavigationController(rootViewController: viewController)
//                    self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
//                }
//            case .config:
//                let storyboard = UIStoryboard(name: "Config", bundle: nil)
//                if let viewController = storyboard.instantiateViewController(withIdentifier: "ConfigViewController") as? ConfigViewController {
//                    let rootViewController = UINavigationController(rootViewController: viewController)
//                    self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
//                }
//            case .contact:
//                let storyboard = UIStoryboard(name: "Contact", bundle: nil)
//                if let viewController = storyboard.instantiateViewController(withIdentifier:
//                    "ContactViewController") as? ContactViewController {
//                    let rootViewController = UINavigationController(rootViewController: viewController)
//                    self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
//                }
//            case .privacy:
//                let storyboard = UIStoryboard(name: "Privacy", bundle: nil)
//                if let viewController = storyboard.instantiateViewController(withIdentifier:
//                    "PrivacyViewController") as? PrivacyViewController {
//                    let rootViewController = UINavigationController(rootViewController: viewController)
//                    self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
//                }
//
//            case .agreement:
//                let storyboard = UIStoryboard(name: "Agreement", bundle: nil)
//                if let viewController = storyboard.instantiateViewController(withIdentifier:
//                    "AgreementViewController") as? AgreementViewController {
//                    let rootViewController = UINavigationController(rootViewController: viewController)
//                    self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
//                }
//
//            case .copyright:
//                let storyboard = UIStoryboard(name: "CopyRight", bundle: nil)
//                if let viewController = storyboard.instantiateViewController(withIdentifier:
//                    "CopyRightViewController") as? CopyRightViewController {
//                    let rootViewController = UINavigationController(rootViewController: viewController)
//                    self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
//                }
//            case .logout:
//                // Todo: ログアウト機能
//                break
//            }
//        }
//    }
}
