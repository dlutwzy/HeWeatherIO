//
//  ConditionCode.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/25.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

enum ConditionCode: Int {

    case sunny = 100
    case cloudy = 101
    case fewCloudy = 102
    case partlyCloudy = 103
    case overcast = 104

    case windy = 200
    case calm = 201
    case lightBreeze = 202
    case moderate = 203
    case freshBreeze = 204
    case strongBreeze = 205
    case highWind = 206
    case gale = 207
    case strongGale = 208
    case storm = 209
    case violentStorm = 210
    case hurricane = 211
    case tornado = 212
    case tropicalStorm = 213

    case showerRain = 300
    case heavyShowerRain = 301
    case thunderShower = 302
    case heavyThunderStorm = 303
    case hail = 304
    case lightRain = 305
    case moderateRain = 306
    case heavyRain = 307
    case extremeRain = 308
    case drizzleRain = 309
    case stormRain = 310
    case heavyStormRain = 311
    case severeStormRain = 312
    case freezingRain = 313

    case lightSnow = 400
    case moderateSnow = 401
    case heavySnow = 402
    case snowstorm = 403
    case sleet = 404
    case rainAndSnow = 405
    case showerSnow = 406
    case snowFlurry = 407

    case mist = 500
    case foggy = 501
    case haze = 502
    case sand = 503
    case dust = 504
    case duststorm = 507
    case sandstorm = 508

    case hot = 900
    case cold = 901

    case unknown = 999
}
