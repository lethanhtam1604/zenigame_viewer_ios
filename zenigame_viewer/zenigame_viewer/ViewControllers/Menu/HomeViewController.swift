//
//  HomeViewController.swift
//  zenigame_viewer
//
//  Created by ykkc on 2017/04/18.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import Alamofire
import ObjectMapper
import OHHTTPStubs
import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet fileprivate weak var liveView: UIView!
    @IBOutlet fileprivate weak var catalogView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        liveView.backgroundColor = UIColor.orange
        catalogView.backgroundColor = UIColor.clear
        self.automaticallyAdjustsScrollViewInsets = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentSize = CGSize(width: view.frame.size.width * 2, height: view.frame.size.height * 2)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self

        view.layoutIfNeeded()
        let liveStoryboard = UIStoryboard(name: "Live", bundle: nil)
        let catalogStoryboard = UIStoryboard(name: "Catalog", bundle: nil)
        if let liveVC = liveStoryboard.instantiateViewController(withIdentifier: "LiveViewController") as? LiveViewController,
            let catalogVC = catalogStoryboard.instantiateViewController(withIdentifier: "CatalogViewController") as? CatalogViewController {
            let liveScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            liveScrollView.contentSize = liveVC.view.frame.size
            scrollView.addSubview(liveScrollView)

            let catalogScrollView = UIScrollView(frame: CGRect(x: scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            catalogScrollView.contentSize = catalogVC.view.frame.size
            scrollView.addSubview(catalogScrollView)

            self.addChildViewController(catalogVC)
            catalogScrollView.addSubview(catalogVC.view)

            self.addChildViewController(liveVC)
            liveScrollView.addSubview(liveVC.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actionLive(_ sender: Any) {
        var frame = scrollView.bounds
        frame.origin.x = 0
        scrollView.scrollRectToVisible(frame, animated: true)
        liveView.backgroundColor = UIColor.orange
        catalogView.backgroundColor = UIColor.clear
    }

    @IBAction func actionCatalog(_ sender: Any) {
        var frame = scrollView.bounds
        frame.origin.x = self.view.frame.size.width
        scrollView.scrollRectToVisible(frame, animated: true)
        liveView.backgroundColor = UIColor.clear
        catalogView.backgroundColor = UIColor.orange
    }

    private func sampleRequest() {
        stub(condition: isHost(Router.host) && isPath(Router.getHomeReponses().path)) { _ in
            return OHHTTPStubsResponse(
                // swiftlint:disable:next force_unwrapping
                fileAtPath: OHPathForFile("home_responses.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        }

        Alamofire.request(Router.getHomeReponses())
            .responseJSON(completionHandler: { response in
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                if let data = response.result.value as? [String: [String: Any]] {
                    if let pickup = data["pickup"], let channels = Mapper<Channel>().mapArray(JSONObject: pickup["channels"]) {
                        _ = channels.map { print($0.toJSON()) }
                    }
                    if let delivery = data["delivery"], let channels = Mapper<Channel>().mapArray(JSONObject: delivery["channels"]) {
                        _ = channels.map { print($0.toJSON()) }
                    }
                    if let event = data["event"], let events = Mapper<EventEntity>().mapArray(JSONObject: event["events"]) {
                        _ = events.map { print($0.toJSON()) }
                    }
                    if let ranking = data["ranking"], let channels = Mapper<Channel>().mapArray(JSONObject: ranking["channels"]) {
                        _ = channels.map { print($0.toJSON()) }
                    }
                    if let gacha = data["gacha"], let gachas = Mapper<GachaEntity>().mapArray(JSONObject: gacha["gachas"]) {
                        _ = gachas.map { print($0.toJSON()) }
                    }
                }
            })
    }

}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if Int((scrollView.contentOffset.x + (0.5 * scrollView.bounds.width)) / scrollView.bounds.width) == 0 {
            self.liveView.backgroundColor = UIColor.orange
            self.catalogView.backgroundColor = UIColor.clear
        } else {
            self.liveView.backgroundColor = UIColor.clear
            self.catalogView.backgroundColor = UIColor.orange
        }
    }
}
