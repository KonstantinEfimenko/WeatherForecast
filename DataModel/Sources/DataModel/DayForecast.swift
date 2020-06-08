//
//  DayForecast.swift
//  
//
//  Created by Kostiantyn YEFYMENKO on 04.06.20.
//

import Foundation

public struct DayForecast {
    
    private let zeroCelsium: Float = 273.15
    
    public let date: String
    public let temp: Int
    public let feelsLike: Int
    public let tempMin: Int
    public let tempMax: Int
    public let icon: String
    
    public init(date: String, array: [ForecastData]) {
        self.date = date
        self.temp = Int(array.map { $0.main.temp }.average() - zeroCelsium)
        self.feelsLike = Int(array.map { $0.main.feelsLike }.average() - zeroCelsium)
        self.tempMin = Int((array.map { $0.main.tempMin }.min() ?? 0) - zeroCelsium)
        self.tempMax = Int((array.map { $0.main.tempMax }.max() ?? 0) - zeroCelsium)
        self.icon = array.first?.weather.first?.icon ?? ""                  // Currently just first icon
    }
}

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}

extension Collection where Element: BinaryFloatingPoint {
    func average() -> Element { isEmpty ? .zero : Element(sum()) / Element(count) }
}
