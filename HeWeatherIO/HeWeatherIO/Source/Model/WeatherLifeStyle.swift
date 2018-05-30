//
//  WeatherLifeStyle.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/30.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

public final class WeatherLifeStyle : HeWeatherBase {

    let lifestyle: [Lifestyle]?

    required public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: WeatherLifeStyle.CodingKeys.self)
        
        lifestyle = try? container.decode([Lifestyle].self, forKey: .lifestyle)

        try super.init(from: decoder)
    }

    private enum CodingKeys: String, CodingKey {
        case lifestyle = "lifestyle"
    }
}

public struct Lifestyle : Codable {

    let brf : String?
    let txt : String?
    let type : String?

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        brf = try values.decodeIfPresent(String.self, forKey: .brf)
        txt = try values.decodeIfPresent(String.self, forKey: .txt)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

    enum CodingKeys: String, CodingKey {
        case brf = "brf"
        case txt = "txt"
        case type = "type"
    }
}
