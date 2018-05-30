//
//  WeatherHourly.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/30.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

public final class WeatherHourly : HeWeatherBase {
    
    let hourly: [HourlyForecast]?

    required public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: WeatherHourly.CodingKeys.self)
        hourly = try? container.decode([HourlyForecast].self, forKey: .hourly)

        try super.init(from: decoder)
    }

    private enum CodingKeys: String, CodingKey {
        case hourly = "hourly"
    }
}

public struct HourlyForecast: Codable {

    let cloud: String?
    let condCode: String?
    let condTxt: String?
    let hum: String?
    let pop: String?
    let pres: String?
    let time: String?
    let tmp: String?
    let windDeg: String?
    let windDir: String?
    let windSc: String?
    let windSpd: String?

    public init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)

        cloud = try values.decodeIfPresent(String.self, forKey: .cloud)
        condCode = try values.decodeIfPresent(String.self, forKey: .condCode)
        condTxt = try values.decodeIfPresent(String.self, forKey: .condTxt)
        hum = try values.decodeIfPresent(String.self, forKey: .hum)
        pop = try values.decodeIfPresent(String.self, forKey: .pop)
        pres = try values.decodeIfPresent(String.self, forKey: .pres)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        tmp = try values.decodeIfPresent(String.self, forKey: .tmp)
        windDeg = try values.decodeIfPresent(String.self, forKey: .windDeg)
        windDir = try values.decodeIfPresent(String.self, forKey: .windDir)
        windSc = try values.decodeIfPresent(String.self, forKey: .windSc)
        windSpd = try values.decodeIfPresent(String.self, forKey: .windSpd)
    }

    private enum CodingKeys: String, CodingKey {
        case cloud = "cloud"
        case condCode = "cond_code"
        case condTxt = "cond_txt"
        case hum = "hum"
        case pop = "pop"
        case pres = "pres"
        case time = "time"
        case tmp = "tmp"
        case windDeg = "wind_deg"
        case windDir = "wind_dir"
        case windSc = "wind_sc"
        case windSpd = "wind_spd"
    }
}
