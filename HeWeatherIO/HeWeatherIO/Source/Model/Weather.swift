//
//  Weather.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/30.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

public class Weather: HeWeatherBase {

    let current: CurrentForecast?
    let dailyForecast: [DailyForecast]?
    let hourly: [HourlyForecast]?
    let lifestyle: [Lifestyle]?

    required public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: Weather.CodingKeys.self)

        current = try container.decode(CurrentForecast.self, forKey: .current)
        dailyForecast = try container.decode([DailyForecast].self, forKey: .dailyForecast)
        hourly = try container.decode([HourlyForecast].self, forKey: .hourly)
        lifestyle = try container.decode([Lifestyle].self, forKey: .lifestyle)

        try super.init(from: decoder)
    }

    override public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: Weather.CodingKeys.self)

        try container.encode(current, forKey: .current)
        try container.encode(dailyForecast, forKey: .dailyForecast)
        try container.encode(hourly, forKey: .hourly)
        try container.encode(lifestyle, forKey: .lifestyle)

        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {

        case dailyForecast = "daily_forecast"
        case hourly = "hourly"
        case lifestyle = "lifestyle"
        case current = "now"
    }
}
