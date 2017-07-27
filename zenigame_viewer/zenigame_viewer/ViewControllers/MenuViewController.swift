//
//  MenuViewController.swift
//  zenigame_viewer
//
//  Created by Thanh-Tam Le on 5/19/17.
//  Copyright © 2017 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit
import FontAwesomeKit

protocol MenuViewDelegate: class {
    func actionTapToMenuItem(viewController: UIViewController, navigateType: Int)
    func actionTapToCloseMenu()
    func actionTapToHeaderMenu()
}

class MenuViewController: UIViewController {

    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeMenuButton: UIButton!

    fileprivate var menus = [Menu]()
    weak var delegate: MenuViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        createMenuData()
        
        containView.layer.cornerRadius = 8
        containView.backgroundColor = UIColor.white
        
        closeMenuButton.imageView?.clipsToBounds = true
        closeMenuButton.imageView?.contentMode = .scaleAspectFit

        tableView.dataSource = self
        tableView.delegate = self
        let cellNib = UINib(nibName: MenuTableViewCell.kCellId, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: MenuTableViewCell.kCellId)
        let headerNib = UINib(nibName: MenuHeaderTableViewCell.kCellId, bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: MenuHeaderTableViewCell.kCellId)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Global.colorMenu
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        tableView.showsVerticalScrollIndicator = false
    }

    func createMenuData() {
        
        var menu = Menu()
        menu.id = 0
        menu.title = "ホーム"
        menu.icon = UIImage(named: "icon_menu_home")
        menus.append(menu)

        menu = Menu()
        menu.id = 1
        menu.numberOfBadge = 15
        menu.title = "LIVE配信中"
        menu.icon = UIImage(named: "icon_menu_live")
        menus.append(menu)

        menu = Menu()
        menu.id = 2
        menu.title = "番組表"
        menu.icon = UIImage(named: "icon_menu_programs")
        menus.append(menu)

        menu = Menu()
        menu.id = 3
        menu.title = "公式チャネル"
        menu.icon = UIImage(named: "icon_menu_official")
        menus.append(menu)

        menu = Menu()
        menu.id = 4
        menu.title = "イベント"
        menu.icon = UIImage(named: "event")
        menus.append(menu)

        menu = Menu()
        menu.id = 5
        menu.title = "ランキング"
        menu.icon = UIImage(named: "icon_menu_ranking")
        menus.append(menu)

        menu = Menu()
        menu.id = 6
        menu.title = "通帳"
        menu.icon = UIImage(named: "icon_menu_bank")
        menus.append(menu)

        menu = Menu()
        menu.id = 7
        menu.numberOfBadge = 15
        menu.title = "お知らせ・通知"
        menu.icon = UIImage(named: "icon_notification")
        menus.append(menu)

        menu = Menu()
        menu.id = 8
        menu.title = "ヘルプ"
        menu.icon = UIImage(named: "icon_menu_help")
        menus.append(menu)

        menu = Menu()
        menu.id = 9
        menu.title = "設定"
        menu.icon = UIImage(named: "icon_menu_setting")
        menus.append(menu)

        menu = Menu()
        menu.id = 10
        menu.title = "ログアウト"
        menu.icon = UIImage(named: "icon_menu_logout")
        menus.append(menu)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actionTapToCloseMenu(_ sender: Any) {
        delegate?.actionTapToCloseMenu()
    }
    
    func actionTapToHeaderMenu() {
        delegate?.actionTapToHeaderMenu()
    }
}

extension MenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuHeaderTableViewCell.kCellId) as! MenuHeaderTableViewCell // swiftlint:disable:this force_cast
        cell.contentView.backgroundColor = UIColor.white
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionTapToHeaderMenu))
        cell.contentView.addGestureRecognizer(tapGestureRecognizer)
        
        return cell.contentView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.kCellId, for: indexPath) as! MenuTableViewCell // swiftlint:disable:this force_cast
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero

        cell.bindingData(menu: menus[indexPath.row])

        return cell
    }
}

extension MenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = menus[indexPath.row]
        switch menu.id {
        case 0:
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                delegate?.actionTapToMenuItem(viewController: viewController, navigateType: NavigateType.Other.rawValue)
            }
        case 1:
            let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier:
                "MyPageViewController") as? MyPageViewController {
                delegate?.actionTapToMenuItem(viewController: viewController, navigateType: NavigateType.Push.rawValue)
            }
        case 2:
            let storyboard = UIStoryboard(name: "OfficialTVProgram", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier:
                "OfficialTVProgramViewController") as? OfficialTVProgramViewController {
                delegate?.actionTapToMenuItem(viewController: viewController, navigateType: NavigateType.Push.rawValue)
            }
        case 3:
            let storyboard = UIStoryboard(name: "DeliveriedTVProgram", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier:
                "DeliveriedTVProgramViewController") as? DeliveriedTVProgramViewController {
                delegate?.actionTapToMenuItem(viewController: viewController, navigateType: NavigateType.Other.rawValue)
            }
        case 4:
            let storyboard = UIStoryboard(name: "Event", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier:
                "EventViewController") as? EventViewController {
                delegate?.actionTapToMenuItem(viewController: viewController, navigateType: NavigateType.Other.rawValue)
            }
        case 5:
            let storyboard = UIStoryboard(name: "Ranking", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier:
                "RankingViewController") as? RankingViewController {
                delegate?.actionTapToMenuItem(viewController: viewController, navigateType: NavigateType.Other.rawValue)
            }
        case 6:
            let storyboard = UIStoryboard(name: "BanaCoinCharge", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier:
                "BanaCoinChargeViewController") as? BanaCoinChargeViewController {
                delegate?.actionTapToMenuItem(viewController: viewController, navigateType: NavigateType.Other.rawValue)
            }
        case 7:
            let storyboard = UIStoryboard(name: "Help", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "HelpViewController") as? HelpViewController {
                delegate?.actionTapToMenuItem(viewController: viewController, navigateType: NavigateType.Other.rawValue)
            }
        case 8:
            let storyboard = UIStoryboard(name: "Config", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "ConfigViewController") as? ConfigViewController {
                delegate?.actionTapToMenuItem(viewController: viewController, navigateType: NavigateType.Other.rawValue)
            }
        case 9:
            let storyboard = UIStoryboard(name: "Contact", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier:
                "ContactViewController") as? ContactViewController {
                delegate?.actionTapToMenuItem(viewController: viewController, navigateType: NavigateType.Other.rawValue)
            }
        case 10:
            let storyboard = UIStoryboard(name: "Privacy", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier:
                "PrivacyViewController") as? PrivacyViewController {
                delegate?.actionTapToMenuItem(viewController: viewController, navigateType: NavigateType.Other.rawValue)
            }

        case 11:
            let storyboard = UIStoryboard(name: "Agreement", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier:
                "AgreementViewController") as? AgreementViewController {
                delegate?.actionTapToMenuItem(viewController: viewController, navigateType: NavigateType.Other.rawValue)
            }

        case 12:
            let storyboard = UIStoryboard(name: "CopyRight", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier:
                "CopyRightViewController") as? CopyRightViewController {
                delegate?.actionTapToMenuItem(viewController: viewController, navigateType: NavigateType.Other.rawValue)
            }
        case 13:
            // Todo: ログアウト機能
            break

        default:
            break

        }
    }
}
