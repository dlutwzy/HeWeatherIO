//
//  AirNow.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/30.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

public final class AirNow: HeWeatherBase {

    let airNowCity : AirNowCity?
    let airNowStation : [AirNowStation]?

    required public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: AirNow.CodingKeys.self)
        airNowCity = try container.decodeIfPresent(AirNowCity.self, forKey: .airNowCity)
        airNowStation = try container.decodeIfPresent([AirNowStation].self, forKey: .airNowStation)

        try super.init(from: decoder)
    }

    override public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: AirNow.CodingKeys.self)
        try container.encode(airNowCity, forKey: .airNowCity)
        try container.encode(airNowStation, forKey: .airNowStation)

        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {

        case airNowCity
        case airNowStation = "air_now_station"
    }
}

struct AirNowStation : Codable {

    let airSta : String?
    let aqi : String?
    let asid : String?
    let co : String?
    let lat : String?
    let lon : String?
    let main : String?
    let no2 : String?
    let o3 : String?
    let pm10 : String?
    let pm25 : String?
    let pubTime : String?
    let qlty : String?
    let so2 : String?

    init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)

        airSta = try values.decodeIfPresent(String.self, forKey: .airSta)
        aqi = try values.decodeIfPresent(String.self, forKey: .aqi)
        asid = try values.decodeIfPresent(String.self, forKey: .asid)
        co = try values.decodeIfPresent(String.self, forKey: .co)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        no2 = try values.decodeIfPresent(String.self, forKey: .no2)
        o3 = try values.decodeIfPresent(String.self, forKey: .o3)
        pm10 = try values.decodeIfPresent(String.self, forKey: .pm10)
        pm25 = try values.decodeIfPresent(String.self, forKey: .pm25)
        pubTime = try values.decodeIfPresent(String.self, forKey: .pubTime)
        qlty = try values.decodeIfPresent(String.self, forKey: .qlty)
        so2 = try values.decodeIfPresent(String.self, forKey: .so2)
    }

    private enum CodingKeys: String, CodingKey {
        case airSta = "air_sta"
        case aqi = "aqi"
        case asid = "asid"
        case co = "co"
        case lat = "lat"
        case lon = "lon"
        case main = "main"
        case no2 = "no2"
        case o3 = "o3"
        case pm10 = "pm10"
        case pm25 = "pm25"
        case pubTime = "pub_time"
        case qlty = "qlty"
        case so2 = "so2"
    }
}

struct AirNowCity : Codable {

    let aqi : String?
    let co : String?
    let main : String?
    let no2 : String?
    let o3 : String?
    let pm10 : String?
    let pm25 : String?
    let pubTime : String?
    let qlty : String?
    let so2 : String?

    init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        aqi = try values.decodeIfPresent(String.self, forKey: .aqi)
        co = try values.decodeIfPresent(String.self, forKey: .co)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        no2 = try values.decodeIfPresent(String.self, forKey: .no2)
        o3 = try values.decodeIfPresent(String.self, forKey: .o3)
        pm10 = try values.decodeIfPresent(String.self, forKey: .pm10)
        pm25 = try values.decodeIfPresent(String.self, forKey: .pm25)
        pubTime = try values.decodeIfPresent(String.self, forKey: .pubTime)
        qlty = try values.decodeIfPresent(String.self, forKey: .qlty)
        so2 = try values.decodeIfPresent(String.self, forKey: .so2)
    }

    private enum CodingKeys: String, CodingKey {
        case aqi = "aqi"
        case co = "co"
        case main = "main"
        case no2 = "no2"
        case o3 = "o3"
        case pm10 = "pm10"
        case pm25 = "pm25"
        case pubTime = "pub_time"
        case qlty = "qlty"
        case so2 = "so2"
    }
}
