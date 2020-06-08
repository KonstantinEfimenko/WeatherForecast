//
//  StorageManager.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 02.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import Foundation
import DataModel

public protocol StorageManagerProtocol {
    func getCities(completion: (([City]) -> Void)?)
    func getForecast(by city: String?, completion: (([DayForecast]) -> Void)?)
}

public class StorageManager: StorageManagerProtocol {
    
    public init() { }
    
    public func getCities(completion: (([City]) -> Void)?) {
        let stubData = [City(name: "Vienna"), City(name: "Kyiv"), City(name: "Puerto-rico")]
        completion?(stubData)
    }
    
    public func getForecast(by city: String?, completion: (([DayForecast]) -> Void)?) {
        ForecastByCityConnection(successHandler: { list in
            completion?(list)
        }, failureHandler: nil)
    }
}
