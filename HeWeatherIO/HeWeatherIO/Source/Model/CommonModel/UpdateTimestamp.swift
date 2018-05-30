//
//  UpdateTimestamp.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/25.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

struct UpdateTimestamp: Codable {

    let loc: String?
    let utc: String?

    private enum CodingKeys: String, CodingKey {
        case loc
        case utc
    }
}

extension UpdateTimestamp {

    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: UpdateTimestamp.CodingKeys.self)

        loc = try container.decode(String.self, forKey: .loc)
        utc = try container.decode(String.self, forKey: .utc)
    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: UpdateTimestamp.CodingKeys.self)

        try container.encode(loc, forKey: .loc)
        try container.encode(utc, forKey: .utc)
    }
}
