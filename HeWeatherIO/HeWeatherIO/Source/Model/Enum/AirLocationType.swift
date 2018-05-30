//
//  LocationType.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/30.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation
import CoreLocation

public enum AirLocationType {

    public typealias IPAddress = (UInt8, UInt8, UInt8, UInt8)

    case coreLocation(location: CLLocation)
    case `id`(id: String)
    case name(name: String)
    case nameList(nameList: [String])
    case `ip`(ip: IPAddress)
    case autoIP

    func stringValue() -> String {
        switch self {

        case .coreLocation(let location):
            return "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        case .id(let id):
            return id
        case .name(let name):
            return name
        case .nameList(let nameList):
            var result = ""
            for (index, str) in nameList.enumerated() {
                if index != 0 {
                    result += ","
                }
                result += str
            }
            return result
        case .ip(let ip):
            return "\(ip.0).\(ip.1).\(ip.2).\(ip.3)"
        case .autoIP:
            return "auto_ip"
        }
    }
}
