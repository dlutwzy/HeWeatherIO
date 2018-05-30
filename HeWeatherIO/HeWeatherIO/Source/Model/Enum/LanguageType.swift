//
//  LanguageType.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/25.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

public enum LanguageType: String {

    case chinese = "zh"
    case traditionalChinese  = "hk"
    case english = "en"
    case german = "de"
    case spanish = "es"
    case french = "fr"
    case italian = "it"
    case japanese = "jp"
    case koream = "kr"
    case russian = "ru"
    case hindi = "in"
    case thai = "th"

    init?(string: String) {

        var value = string
        if string == "zh-cn" || string == "cn" {
            value = "zh"
        } else if string == "zh-hk" {
            value = "hk"
        }
        self.init(rawValue: value)
    }
}
