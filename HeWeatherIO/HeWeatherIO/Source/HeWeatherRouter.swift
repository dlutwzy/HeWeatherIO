//
//  HeWeatherRouter.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/25.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation
import CoreLocation

protocol URLRequestConvertible {
    typealias QueryParameters = [String: Any]
    func asURLRequest(parameters: QueryParameters?, authType: HeWeatherClient.HeWeatherAuthType) -> URLRequest?
}

enum HeWeatherRouter: URLRequestConvertible {

    case forecast(location: AirLocationType)
    case now(location: AirLocationType)
    case hourly(location: AirLocationType)
    case lifestyle(location: AirLocationType)
    case weather(location: AirLocationType)
    case airNow(location: AirLocationType)

    func asURLRequest(parameters: QueryParameters?, authType: HeWeatherClient.HeWeatherAuthType) -> URLRequest? {

        let result: (path: String, parameters: QueryParameters) = {
            switch self {
            case .forecast(let location):
                return ("/weather/forecast",
                        ["location": location.stringValue()]
                )
            case .now(let location):
                return ("/weather/now",
                        ["location": location.stringValue()]
                )
            case .hourly(let location):
                return ("/weather/hourly",
                        ["location": location.stringValue()]
                )
            case .lifestyle(let location):
                return ("/weather/lifestyle",
                        ["location": location.stringValue()]
                )
            case .weather(let location):
                return ("/weather",
                        ["location": location.stringValue()]
                )
            case .airNow(let location):
                return ("/air/now",
                        ["location": location.stringValue()]
                )
            }
        }()

        var urlStr = HeWeatherRouter.baseURLString + result.path
        let allParameters = parameters == nil ? result.parameters : result.parameters.merging(parameters!, uniquingKeysWith: { (first, _) -> Any in
            return first
        })

        switch authType {
        case .key:
            urlStr += "?" + allParameters.queryString()
        case .sign:
            if let signDict = allParameters.signQuery() {
                urlStr += "?" + signDict.queryString()
            } else {
                print("sign query is null")
            }
        }

        guard let url = URL(string: urlStr) else {
            return nil
        }
        
        return URLRequest(url: url)
    }

    private static let baseURLString = "https://free-api.heweather.com/s6"
}

extension Dictionary where Key == String, Value == Any {

    fileprivate func queryString() -> String {
        var str = ""
        for item in self.enumerated() {
            if item.offset != 0 {
                str += "&"
            }
            str += "\(item.element.key)=\(item.element.value)"
        }
        return str
    }

    fileprivate func signQuery() -> Dictionary<String, Any>? {

        guard let _ = self["username"],
            let key = self["key"] as? String else {
                return nil
        }

        var signDict = self.filter { (element) -> Bool in
            if element.key != "sign" &&
                element.key != "key" &&
                (element.value as? String != nil &&
                    element.value as? String != "") {

                return true
            } else {
                return false
            }
        }

        let sortSignList = signDict.sorted { (first, second) -> Bool in
            return first.key < second.key
        }

        var str = ""
        for (index, item) in sortSignList.enumerated() {
            if index != 0 {
                str += "&"
            }
            str += "\(item.key)=\(item.value)"
        }
        str += key

        let md5 = str.md5()
        let signBase64Str = md5.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        let characterSet = CharacterSet(charactersIn: "/+").inverted
        signDict["sign"] = signBase64Str.addingPercentEncoding(withAllowedCharacters: characterSet) ?? ""

        return signDict
    }
}
