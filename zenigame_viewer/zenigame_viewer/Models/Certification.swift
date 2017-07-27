//
//  Certification.swift
//  zenigame_viewer
//
//  Created by Kaoru Tsutsumishita on 2017/05/23.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import ObjectMapper

final class Certification: Mappable {

    var result: Bool = false

    init() {
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        result <- map["certification.result"]
    }

}
