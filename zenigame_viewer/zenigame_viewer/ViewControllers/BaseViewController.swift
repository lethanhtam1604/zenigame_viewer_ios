//
//  BaseViewController.swift
//  zenigame_viewer
//
//  Created by 笹野駿 on 2017/04/25.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit
import FontAwesomeKit

enum NavigateType: Int {
    case Push = 0
    case Present = 1
    case Other = 2
}

class BaseViewController: UIViewController, MenuViewDelegate {
    
    let abstractView = UIView()
    let navigationBarView = UIView()
    let menuButton = UIButton()
    let backButton = UIButton()
    let userInfoButton = UIButton()
    let channelView = UIView()
    let channelLabel = UILabel()
    let timeButton = UIButton()
    let timerLabel = UILabel()
    let channelInfoButton = UIButton()
    let numberLabel = UILabel()
    let closeButton = UIButton()
    
    var menuView: UIView!
    
    var constraintsAdded = false
    var topMenuConstraint: NSLayoutConstraint!
    var heightMenuConstraint: NSLayoutConstraint!
    var widthMenuConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        abstractView.isHidden = true
        abstractView.backgroundColor = UIColor.clear
        let abstractGesture = UITapGestureRecognizer(target: self, action:  #selector(actionTapToMenu))
        abstractView.addGestureRecognizer(abstractGesture)

        navigationBarView.backgroundColor = Global.colorNavBar
        
        menuButton.setImage(UIImage(named: "btn_list"), for: .normal)
        menuButton.backgroundColor = UIColor.clear
        menuButton.clipsToBounds = true
        menuButton.addTarget(self, action: #selector(actionTapToMenu), for: .touchUpInside)
        
        let backImage = UIImage(named: "i_nav_back")
        let backTintedImage = backImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backTintedImage, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.isHidden = true
        backButton.backgroundColor = UIColor.clear
        backButton.imageView?.clipsToBounds = true
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(actionTapToBack), for: .touchUpInside)
        
        userInfoButton.setImage(UIImage(named: "btn_user_info"), for: .normal)
        userInfoButton.backgroundColor = UIColor.clear
        userInfoButton.clipsToBounds = true
        
        channelView.backgroundColor = Global.colorChannel
        channelView.layer.cornerRadius = 10
        
        channelLabel.text = "人気動画タイトル..."
        channelLabel.font = UIFont.boldSystemFont(ofSize: 16)
        channelLabel.textAlignment = .left
        channelLabel.textColor = UIColor.black
        channelLabel.lineBreakMode = .byWordWrapping
        channelLabel.numberOfLines = 0
        
        let timeIcon = FAKIonIcons.androidTimeIcon(withSize: 20)
        timeIcon?.addAttribute(NSForegroundColorAttributeName, value: UIColor.black)
        let timeImg = timeIcon?.image(with: CGSize(width: 20, height: 20))
        timeButton.setImage(timeImg, for: .normal)
        timeButton.backgroundColor = UIColor.clear
        timeButton.clipsToBounds = true
        
        timerLabel.text = "あと 01 : 02 : 03"
        timerLabel.font = UIFont.systemFont(ofSize: 11)
        timerLabel.textAlignment = .left
        timerLabel.textColor = UIColor.black
        timerLabel.lineBreakMode = .byWordWrapping
        timerLabel.numberOfLines = 0
        
        channelInfoButton.setImage(UIImage(named: "btn_channel_info"), for: .normal)
        channelInfoButton.backgroundColor = UIColor.clear
        channelInfoButton.clipsToBounds = true
        
        numberLabel.text = "1000"
        numberLabel.font = UIFont.systemFont(ofSize: 15)
        numberLabel.textAlignment = .center
        numberLabel.textColor = UIColor.black
        numberLabel.lineBreakMode = .byWordWrapping
        numberLabel.numberOfLines = 0
        
        closeButton.setImage(UIImage(named: "btn_close"), for: .normal)
        closeButton.backgroundColor = UIColor.clear
        closeButton.clipsToBounds = true
        
        channelView.addSubview(channelLabel)
        channelView.addSubview(timeButton)
        channelView.addSubview(timerLabel)
        channelView.addSubview(channelInfoButton)
        
        let slideMenuStoryboard = UIStoryboard(name: "Menu", bundle: nil)
        let menuViewController = slideMenuStoryboard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        menuViewController?.delegate = self
        addChildViewController(menuViewController!)
        menuViewController?.didMove(toParentViewController: self)
        menuView = menuViewController?.view
        menuView.layer.cornerRadius = 8
        menuView.backgroundColor = Global.colorMenu
        
        navigationBarView.addSubview(menuButton)
        navigationBarView.addSubview(backButton)
        navigationBarView.addSubview(channelView)
        navigationBarView.addSubview(userInfoButton)
        navigationBarView.addSubview(numberLabel)
        navigationBarView.addSubview(closeButton)
            
        view.addSubview(abstractView)
        view.addSubview(menuView)
        view.addSubview(navigationBarView)

        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        if !constraintsAdded {
            constraintsAdded = true
            
            navigationBarView.autoPinEdge(toSuperviewEdge: .top)
            navigationBarView.autoPinEdge(toSuperviewEdge: .left)
            navigationBarView.autoPinEdge(toSuperviewEdge: .right)
            navigationBarView.autoSetDimension(.height, toSize: 64)
            
            menuButton.autoSetDimensions(to: CGSize(width: 34, height: 34))
            menuButton.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
            menuButton.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
            
            backButton.autoSetDimensions(to: CGSize(width: 34, height: 34))
            backButton.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
            backButton.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
            
            closeButton.autoSetDimensions(to: CGSize(width: 34, height: 34))
            closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
            closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
            
            numberLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
            numberLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
            numberLabel.autoPinEdge(.right, to: .left, of: closeButton, withOffset: -5)
            numberLabel.autoSetDimension(.width, toSize: 40)
            
            userInfoButton.autoSetDimensions(to: CGSize(width: 34, height: 34))
            userInfoButton.autoPinEdge(.right, to: .left, of: numberLabel, withOffset: -5)
            userInfoButton.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
            
            channelView.autoPinEdge(.left, to: .right, of: menuButton, withOffset: 5)
            channelView.autoPinEdge(.right, to: .left, of: userInfoButton, withOffset: -5)
            channelView.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
            channelView.autoSetDimension(.height, toSize: 34)
            
            channelInfoButton.autoSetDimensions(to: CGSize(width: 30, height: 30))
            channelInfoButton.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
            channelInfoButton.autoAlignAxis(toSuperviewAxis: .horizontal)
            
            timeButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 2)
            timeButton.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
            timeButton.autoSetDimensions(to: CGSize(width: 12, height: 12))
            
            timerLabel.autoPinEdge(.right, to: .left, of: channelInfoButton, withOffset: -5)
            timerLabel.autoPinEdge(.left, to: .right, of: timeButton, withOffset: 5)
            timerLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 2)
            timerLabel.autoSetDimension(.height, toSize: 12)
            
            channelLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
            channelLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
            channelLabel.autoPinEdge(.right, to: .left, of: channelInfoButton, withOffset: -5)
            channelLabel.autoPinEdge(.bottom, to: .top, of: timerLabel, withOffset: -5)
            
            menuView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            widthMenuConstraint = menuView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width/2 + 10 + 12)
            heightMenuConstraint = menuView.autoSetDimension(.height, toSize: UIScreen.main.bounds.height - 104)
            topMenuConstraint = menuView.autoPinEdge(.top, to: .bottom, of: navigationBarView, withOffset: -10 - (UIScreen.main.bounds.height - 104))

            abstractView.autoPinEdge(.top, to: .bottom, of: navigationBarView, withOffset: 0)
            abstractView.autoPinEdge(toSuperviewEdge: .right)
            abstractView.autoPinEdge(toSuperviewEdge: .left)
            abstractView.autoPinEdge(toSuperviewEdge: .bottom)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        widthMenuConstraint.constant = UIScreen.main.bounds.width/2 + 10 + 12
        heightMenuConstraint.constant = UIScreen.main.bounds.height - 104
    }
    
    var isOpenMenu = false
    
    func actionTapToMenu() {
        UIView.animate(withDuration: Double(0.5), animations: {
            if !self.isOpenMenu {
                self.openMenu()
            }
            else {
                self.closeMenu()
            }
            self.view.layoutIfNeeded()
        })
    }
    
    func openMenu() {
        abstractView.isHidden = false
        self.topMenuConstraint.constant = -10
        self.isOpenMenu = true
    }
    
    func closeMenu() {
        abstractView.isHidden = true
        self.topMenuConstraint.constant = -10 - heightMenuConstraint.constant
        self.isOpenMenu = false
    }
    
    func actionTapToMenuItem(viewController: UIViewController, navigateType: Int) {
        
        UIView.animate(withDuration: Double(0.5), animations: {
            self.closeMenu()
            self.view.layoutIfNeeded()
        },completion: { _ in
            if navigateType == NavigateType.Push.rawValue {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            else if navigateType == NavigateType.Present.rawValue {
                
            }
            else {
                guard let window = UIApplication.shared.delegate?.window else {
                    return
                }
                
                let navigationController = UINavigationController(rootViewController: viewController)
                window?.rootViewController = navigationController
            }
        })
    }
    
    func actionTapToHeaderMenu() {
        UIView.animate(withDuration: Double(0.5), animations: {
            self.closeMenu()
            self.view.layoutIfNeeded()
        },completion: { _ in
            let myPageStoryboard = UIStoryboard(name: "MyPage", bundle: nil)
            if let viewController = myPageStoryboard.instantiateViewController(withIdentifier: "MyPageViewController") as? MyPageViewController {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        })
    }
    
    func actionTapToCloseMenu() {
        actionTapToMenu()
    }
    
    func actionTapToBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func actionTapToClose() {
        
    }
    
    func actionTapToUserInfo() {
        
    }
}
