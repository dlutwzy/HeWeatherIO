//
//  ResponseStatus.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/30.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

public enum ResponseStatus: String {
    case `ok` = "ok"
    case permissionDenied = "permission denied"
    case invalidSign = "sign error"
    case invalidpParamters = "param invalid"
    case invalidKey = "invalid key"
    case noDataForThisLocation = "no data for this location"
    case unknownLocation = "unknown location"
    case noMoreRequests = "no more requests"
    case requestTooFast = "too fast"
    case noResponse = "dead"
}
