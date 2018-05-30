//
//  HeWeatherClient.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/25.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation
import CoreLocation

extension HeWeatherClient {

    public func getForecast(location: AirLocationType,
                            units: UintsType? = nil,
                            language: LanguageType? = nil,
                            completionHandler: @escaping (Result<[WeatherForecast]?>) -> Void) {

        getWeatherInfo(requestType: HeWeatherRouter.forecast(location: location),
                       units: units,
                       language: language,
                       completionHandler: completionHandler)
    }

    public func getCurrentCondition(location: AirLocationType,
                                    units: UintsType? = nil,
                                    language: LanguageType? = nil,
                                    completionHandler: @escaping (Result<[WeatherNow]?>) -> Void) {

        getWeatherInfo(requestType: HeWeatherRouter.now(location: location),
                       units: units,
                       language: language,
                       completionHandler: completionHandler)
    }

    public func getHourlyForecast(location: AirLocationType,
                                  units: UintsType? = nil,
                                  language: LanguageType? = nil,
                                  completionHandler: @escaping (Result<[WeatherHourly]?>) -> Void) {

        getWeatherInfo(requestType: HeWeatherRouter.hourly(location: location),
                       units: units,
                       language: language,
                       completionHandler: completionHandler)
    }

    public func getLifestyle(location: AirLocationType,
                             units: UintsType? = nil,
                             language: LanguageType? = nil,
                             completionHandler: @escaping (Result<[WeatherLifeStyle]?>) -> Void) {

        getWeatherInfo(requestType: HeWeatherRouter.lifestyle(location: location),
                       units: units,
                       language: language,
                       completionHandler: completionHandler)
    }

    public func getWeather(location: AirLocationType,
                           units: UintsType? = nil,
                           language: LanguageType? = nil,
                           completionHandler: @escaping (Result<[Weather]?>) -> Void) {

        getWeatherInfo(requestType: HeWeatherRouter.weather(location: location),
                       units: units,
                       language: language,
                       completionHandler: completionHandler)
    }

    public func getAirNow(location: AirLocationType,
                          units: UintsType? = nil,
                          language: LanguageType? = nil,
                          completionHandler: @escaping (Result<[AirNow]?>) -> Void) {

        getWeatherInfo(requestType: HeWeatherRouter.airNow(location: location),
                       units: units,
                       language: language,
                       completionHandler: completionHandler)
    }
}

public class HeWeatherClient {

    public var units: UintsType = .m
    public var language: LanguageType = .chinese

    public init(authByKey apiKey: String) {
        self.userName = nil
        self.apiKey = apiKey
        self.authType = .key
    }

    public init(authBySign userName: String, apiKey: String) {
        self.userName = userName
        self.apiKey = apiKey
        self.authType = .sign
    }

    private let userName: String?
    private let apiKey: String
    private let authType: HeWeatherAuthType
    private let session = URLSession.shared

    enum HeWeatherAuthType {
        case key
        case sign
    }
}

extension HeWeatherClient {

    private func getWeatherInfo<T: Codable>(requestType: HeWeatherRouter,
                                   units: UintsType? = nil,
                                   language: LanguageType? = nil,
                                   completionHandler: @escaping (Result<[T]?>) -> Void) {

        guard let request = weatherRequest(requestType: requestType,
                                           units: units,
                                           language: language) else {
                                            return
        }

        self.session.request(request: request) { (result: Result<WeatherContainer<T>>) in
            switch result {

            case .success(_):
                completionHandler(Result.success(result.value?.heWeather))
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }

    private func weatherRequest(requestType: HeWeatherRouter,
                                units: UintsType? = nil,
                                language: LanguageType? = nil) -> URLRequest? {

        let paramters = basicParamters(language: language, units: units)
        return requestType.asURLRequest(parameters: paramters, authType: self.authType)
    }

    private func basicParamters(language: LanguageType?, units: UintsType?) -> URLRequestConvertible.QueryParameters {
        var paramters = URLRequestConvertible.QueryParameters()
        paramters["lang"] = language?.rawValue ?? self.language.rawValue
        paramters["unit"] = units?.rawValue ?? self.units.rawValue

        switch self.authType {

        case .key:
            paramters["key"] = self.apiKey
        case .sign:
            paramters["t"] = "\(Int(Date().timeIntervalSince1970))"
            paramters["username"] = self.userName!
            paramters["key"] = self.apiKey
        }

        return paramters
    }
}
