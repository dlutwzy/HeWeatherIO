//
//  HeWeatherError.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/25.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

enum HeWeatherError: Error {
    case unknownError(Error?)
    case noDataError
    case noResponseError
    case decodeError
}
