//
//  String+MD5.swift
//  HeWeatherIO
//
//  Created by WZY on 2018/5/28.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation
import NSString_MD5

extension String {
    func md5() -> Data {
        return MD5.md5(self)
    }
}
