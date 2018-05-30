//
//  HeWeatherBase.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/25.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

public class HeWeatherBase: Codable {

    var basic: LocationAttribute?
    var update: UpdateTimestamp?
    var status: ResponseStatus

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HeWeatherBase.CodingKeys.self)

        basic = try? container.decode(LocationAttribute.self, forKey: .basic)
        update = try? container.decode(UpdateTimestamp.self, forKey: .update)
        status = ResponseStatus(rawValue: try container.decode(String.self, forKey: .status))!
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: HeWeatherBase.CodingKeys.self)

        try container.encode(basic, forKey: .basic)
        try container.encode(update, forKey: .update)
        try container.encode(status.rawValue, forKey: .status)
    }

    private enum CodingKeys: String, CodingKey {
        case basic
        case update
        case status
    }
}
