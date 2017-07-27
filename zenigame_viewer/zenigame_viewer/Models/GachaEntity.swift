//
//  GachaEntity.swift
//  zenigame_viewer
//
//  Created by Kaoru Tsutsumishita on 2017/06/13.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import UIKit
import ObjectMapper

final class GachaEntity: Mappable {

    var id = 0
    var thumbnailUrl: String?

    init() {
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["gacha_id"]
        thumbnailUrl <- map["thumbnail_url"]
    }

}
