//
//  Forecast.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/25.
//  Copyright © 2018年 iMac. All rights reserved.
//
/*
 * 变更：Forecast.swift -> WeatherForecast.swift
 */

import Foundation

public final class WeatherForecast: HeWeatherBase {

    public var dailyForecast: [DailyForecast]?

    required public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: WeatherForecast.CodingKeys.self)
        dailyForecast = try? container.decode([DailyForecast].self, forKey: .dailyForecast)

        try super.init(from: decoder)
    }

    override public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: WeatherForecast.CodingKeys.self)
        try container.encode(dailyForecast, forKey: .dailyForecast)

        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case dailyForecast = "daily_forecast"
    }
}

public struct DailyForecast: Codable {

    let condCodeD: ConditionCode?
    let condCodeN: ConditionCode?
    let condTxtD: String?
    let condTxtN: String?
    let date: Date?
    let hum: String?
    let mr: String?
    let ms: String?
    let pcpn: String?
    let pop: String?
    let pres: String?
    let sr: String?
    let ss: String?
    let tmpMax: Int?
    let tmpMin: Int?
    let uvIndex: String?
    let vis: String?
    let windDeg: String?
    let windDir: String?
    let windSc: String?
    let windSpd: String?

    private enum CodingKeys: String, CodingKey {
        case condCodeD = "cond_code_d"
        case condCodeN = "cond_code_n"
        case condTxtD = "cond_txt_d"
        case condTxtN = "cond_txt_n"
        case date
        case hum
        case mr
        case ms
        case pcpn
        case pop
        case pres
        case sr
        case ss
        case tmpMax = "tmp_max"
        case tmpMin = "tmp_min"
        case uvIndex = "uv_index"
        case vis
        case windDeg = "wind_deg"
        case windDir = "wind_dir"
        case windSc = "wind_sc"
        case windSpd = "wind_spd"
    }
}

extension DailyForecast {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DailyForecast.CodingKeys.self)

        let condCodeDStr = try container.decode(String.self, forKey: .condCodeD)
        condCodeD = ConditionCode(rawValue: Int(condCodeDStr) ?? 999)
        let condCodeNStr = try container.decode(String.self, forKey: .condCodeN)
        condCodeN = ConditionCode(rawValue: Int(condCodeNStr) ?? 999)
        condTxtD = try container.decode(String.self, forKey: .condTxtD)
        condTxtN = try container.decode(String.self, forKey: .condTxtN)

        let dateStr = try container.decode(String.self, forKey: .date)
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd hh:mm:ss Z"
        date = dateFormat.date(from: dateStr + " 12:00:00 +0800")

        hum = try container.decode(String.self, forKey: .hum)
        mr = try container.decode(String.self, forKey: .mr)
        ms = try container.decode(String.self, forKey: .ms)
        pcpn = try container.decode(String.self, forKey: .pcpn)
        pop = try container.decode(String.self, forKey: .pop)
        pres = try container.decode(String.self, forKey: .pres)
        sr = try container.decode(String.self, forKey: .sr)
        ss = try container.decode(String.self, forKey: .ss)
        tmpMax = Int(try container.decode(String.self, forKey: .tmpMax))
        tmpMin = Int(try container.decode(String.self, forKey: .tmpMin))
        uvIndex = try container.decode(String.self, forKey: .uvIndex)
        vis = try container.decode(String.self, forKey: .vis)
        windDeg = try container.decode(String.self, forKey: .windDeg)
        windDir = try container.decode(String.self, forKey: .windDir)
        windSc = try container.decode(String.self, forKey: .windSc)
        windSpd = try container.decode(String.self, forKey: .windSpd)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DailyForecast.CodingKeys.self)

        try container.encode("\(condCodeD?.rawValue ?? 999)", forKey: .condCodeD)
        try container.encode("\(condCodeN?.rawValue ?? 999)", forKey: .condCodeN)
        try container.encode(condTxtD, forKey: .condTxtD)
        try container.encode(condTxtN, forKey: .condTxtN)

        if let date = date {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd hh:mm:ss Z"
            try container.encode(dateFormat.string(from: date), forKey: .date)
        }

        try container.encode(hum, forKey: .hum)
        try container.encode(mr, forKey: .mr)
        try container.encode(ms, forKey: .ms)
        try container.encode(pcpn, forKey: .pcpn)
        try container.encode(pop, forKey: .pop)
        try container.encode(pres, forKey: .pres)
        try container.encode(sr, forKey: .sr)
        try container.encode(ss, forKey: .ss)
        if let tmpMax = tmpMax {
            try container.encode("\(tmpMax)", forKey: .tmpMax)
        }
        if let tmpMin = tmpMin {
            try container.encode("\(tmpMin)", forKey: .tmpMin)
        }
        try container.encode(uvIndex, forKey: .uvIndex)
        try container.encode(vis, forKey: .vis)
        try container.encode(windDeg, forKey: .windDeg)
        try container.encode(windDir, forKey: .windDir)
        try container.encode(windSc, forKey: .windSc)
        try container.encode(windSpd, forKey: .windSpd)
    }
}
