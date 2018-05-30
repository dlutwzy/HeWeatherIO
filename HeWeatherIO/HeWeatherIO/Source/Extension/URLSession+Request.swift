//
//  URLSession+Request.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/28.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

extension URLSession {

    func request<T: Codable>(request: URLRequest, queue: DispatchQueue? = nil, completionHandler: @escaping (Result<T>) -> Void) {

        let task = self.dataTask(with: request) { (data, response, error) in
            var result: Result<T> = .failure(HeWeatherError.unknownError(nil))
            defer {
                (queue ?? DispatchQueue.main).async {
                    completionHandler(result)
                }
            }

            if let error = error {
                result = .failure(HeWeatherError.unknownError(error))
                return
            }
            guard let _ = response else {
                result = .failure(HeWeatherError.noResponseError)
                return
            }
            guard let data = data else {
                result = .failure(HeWeatherError.noDataError)
                return
            }

            print(String(data: data, encoding: String.Encoding.utf8))
            let decoder = JSONDecoder()
            if let value = try? decoder.decode(T.self, from: data) {
                result = .success(value)
            } else {
                result = .failure(HeWeatherError.decodeError)
            }
        }
        task.resume()
    }
}
