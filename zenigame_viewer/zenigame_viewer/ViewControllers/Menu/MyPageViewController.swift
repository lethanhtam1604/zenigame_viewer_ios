//
//  MyPageViewController.swift
//  zenigame_viewer
//
//  Created by Kaoru Tsutsumishita on 2017/04/22.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

class MyPageViewController: BaseViewController {

    @IBOutlet private weak var avatarIconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nickNameLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var levelLabel: UILabel!
    @IBOutlet private weak var updateProfileButton: UIButton!
    @IBOutlet private weak var introTextView: UITextView!
    
    var userProfile = UserProfile()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        navigationBarView.isHidden = true
        menuView.isHidden = true
        
        title = "マイページ"
        
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        let backBarButton = UIBarButtonItem(image: UIImage(named: "i_nav_back"), style: .done, target: self, action: #selector(actionTapToBackButton))
        backBarButton.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = backBarButton
        
        let settingBarButton = UIBarButtonItem(image: UIImage(named: "ic_settings"), style: .done, target: self, action: #selector(actionTapToSettingButton))
        settingBarButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = settingBarButton
        
        updateProfileButton.layer.cornerRadius = 3
        introTextView.isEditable = false
        introTextView.textContainer.lineBreakMode = .byWordWrapping
        
        loadData()
    }
    
    func loadData() {
        userProfile.id = 1000000000000
        userProfile.avatarUrl = ""
        userProfile.title = "称号"
        userProfile.nickname = "ニックネーム"
        userProfile.level = 1
        userProfile.introYourself = "こんにちは！4234872394823984732984728947983 こんにちは！4234872394823984732984728947983 こんにちは！4234872394823984732984728947983 こんにちは！4234872394823984732984728947983"
        
        titleLabel.text = userProfile.title
        nickNameLabel.text = userProfile.nickname
        idLabel.text = "ID: " + "\(userProfile.id)"
        levelLabel.text = "Lv: " + "\(userProfile.level)" + "（現在の経験値/次のレベルまで経験値)"
        introTextView.text = userProfile.introYourself
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func actionToTapUpdateProfileButton(_ sender: Any) {
        
    }
    
    @IBAction func actionToTapFavouriteButton(_ sender: Any) {
        
    }
    
    @IBAction func actionToTapNotificationButton(_ sender: Any) {
        
    }
    
    @IBAction func actionToTapCoinButton(_ sender: Any) {
        
    }
    
    func actionTapToSettingButton() {

    }
    
    func actionTapToBackButton() {
        navigationBarView.isHidden = false
        menuView.isHidden = false
        navigationController?.isNavigationBarHidden = true
        _ = navigationController?.popViewController(animated: true)
    }
}
