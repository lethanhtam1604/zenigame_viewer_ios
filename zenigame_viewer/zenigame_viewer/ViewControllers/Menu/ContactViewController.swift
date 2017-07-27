//
//  ContactViewController.swift
//  zenigame_viewer
//
//  Created by 笹野駿 on 2017/04/25.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: BaseViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var faqButton: UIButton!
    @IBOutlet private weak var contactTitleLabel: UILabel!
    @IBOutlet private weak var contactButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        faqButton.layer.borderColor = UIColor.black.cgColor
        faqButton.layer.borderWidth = 1

        contactButton.layer.borderColor = UIColor.black.cgColor
        contactButton.layer.borderWidth = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actionTapToFAQButton(_ sender: Any) {
        let viewControlelr = FAQViewController.instantiate(storyboard: "FAQ")
        let nav = UINavigationController(rootViewController: viewControlelr)
        present(nav, animated: true, completion: nil)
    }

    @IBAction func actionTapToContactButton(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["xxx@gmail.com"])
            mail.setSubject("feedback for application")
            mail.setMessageBody("feedback content for application", isHTML: false)
            mail.navigationBar.isTranslucent = false
            mail.navigationBar.tintColor = UIColor.blue
            self.present(mail, animated: true, completion: nil)
        } else {
            Utils.showAlert(title: "Error", message: "You are not logged in e-mail. Please check e-mail configuration and try again", viewController: self)
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
