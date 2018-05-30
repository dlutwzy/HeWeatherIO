//
//  Result.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/25.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

public enum Result<Value> {
    
    case success(Value)
    case failure(Error)

    var value: Value? {

        switch self {

        case .success(let value):
            return (value)
        case .failure(_):
            return nil
        }
    }

    var error: Error? {

        switch self {

        case .success(_):
            return nil
        case .failure(let error):
            return error
        }
    }
}
