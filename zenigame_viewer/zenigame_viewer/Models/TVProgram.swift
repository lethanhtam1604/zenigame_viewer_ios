//
//  TVProgram.swift
//  zenigame_viewer
//
//  Created by 堤下薫 on 2017/06/10.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit
import ObjectMapper

final class TVProgram: Mappable {

    var id = 0
    var channelId = 0
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
        id <- map["program_id"]
        channelId <- map["channel_id"]
        thumbnailUrl <- map["thumbnail_url"]
        watcherCount <- map["watcher_count"]
        registerCount <- map["register_count"]
        ptCount <- map["pt_count"]
        startAt <- map["start_at"]
        endAt <- map["start_at"]
    }

}
