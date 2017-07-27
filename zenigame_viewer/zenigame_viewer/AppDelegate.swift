//
//  AppDelegate.swift
//  zenigame_viewer
//
//  Created by ykkc on 2017/04/18.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let mainStoryboard = UIStoryboard(name: "Home", bundle: nil)
//        let slideMenuStoryboard = UIStoryboard(name: "Menu", bundle: nil)
        if let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
//            let menuViewController = slideMenuStoryboard.instantiateViewController(withIdentifier:
//                "MenuViewController") as? MenuViewController {
            let navigationController = UINavigationController(rootViewController: mainViewController)
//            let slideMenuController = SlideMenuController(mainViewController: navigationController,
//                                                          leftMenuViewController: menuViewController)
//            slideMenuController.changeLeftViewWidth(UIScreen.main.bounds.size.width / 2 + 20)
            self.window?.rootViewController = navigationController
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
