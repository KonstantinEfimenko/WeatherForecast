//
//  Bundle+Extensions.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 03.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import Foundation

private class LocalClass { }

public extension Bundle {
    static var current: Bundle {
        return Bundle(for: LocalClass.self)
    }
}
