//
//  String+DateExtension.swift
//  zenigame_viewer
//
//  Created by Kaoru Tsutsumishita on 2017/06/02.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import Foundation

extension String {

    private static let dateFormatter = { () -> DateFormatter in
        let df = DateFormatter()
        df.locale = Locale.current
        return df
    }()

    func convertTo(format: String) -> String? {
        let apiTimestampFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        String.dateFormatter.dateFormat = apiTimestampFormat
        guard let date = String.dateFormatter.date(from: self) else {
            return nil
        }
        String.dateFormatter.dateFormat = format
        return String.dateFormatter.string(from: date)
    }

}
