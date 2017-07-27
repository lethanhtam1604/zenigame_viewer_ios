//
//  Channel.swift
//  zenigame
//
//  Created by Thanh-Tam Le on 4/27/17.
//  Copyright © 2017 Anime Consortium Japan. All rights reserved.
//

import UIKit
import ObjectMapper

final class Channel: Mappable {

    var id = 0
    var thumbnailUrl: String?
    var watcherCount = 0
    var registerCount = 0
    var ptCount = 0
    var startAt: String?
    var endAt: String?

    init() {
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["channel_id"]
        thumbnailUrl <- map["thumbnail_url"]
        watcherCount <- map["watcher_count"]
        registerCount <- map["register_count"]
        ptCount <- map["pt_count"]
        startAt <- map["start_at"]
        endAt <- map["start_at"]
    }

}
