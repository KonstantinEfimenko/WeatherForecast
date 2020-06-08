//
//  ForecastData.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 02.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import Foundation

public struct ForecastData: Decodable {
    public let main: MainForecastData
    public let weather: [WeatherForecastData]
    let dt_txt: String
    public var date: String {
        dt_txt.components(separatedBy: " ")[0]
    }
}
