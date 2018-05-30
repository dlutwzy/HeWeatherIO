//
//  WeatherContainer.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/30.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

struct WeatherContainer<T: Codable>: Codable {

    let heWeather: [T]?

    private enum CodingKeys: String, CodingKey {
        case heWeather = "HeWeather6"
    }
}

extension WeatherContainer {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeatherContainer.CodingKeys.self)

        heWeather = try container.decode([T].self, forKey: .heWeather)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: WeatherContainer.CodingKeys.self)

        try container.encode(heWeather, forKey: .heWeather)
    }
}
