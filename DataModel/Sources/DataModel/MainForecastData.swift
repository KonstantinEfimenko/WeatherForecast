//
//  MainForecastData.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 02.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import Foundation

public struct MainForecastData: Decodable {
    public let temp: Float
    public let feelsLike: Float
    public let tempMin: Float
    public let tempMax: Float
    
    enum CodingKeys: String, CodingKey {
      case temp, feelsLike = "feels_like", tempMin = "temp_min", tempMax = "temp_max"
    }
}
