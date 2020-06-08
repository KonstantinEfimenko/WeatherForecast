//
//  CoordinatorFactory.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 03.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import DataService

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    func makeForecastByCityCoordinator(router: RouterProtocol, storageManager: StorageManagerProtocol) -> CoordinatorProtocol {
        return ForecastByCityCoordinator(router: router, storageManager: storageManager)
    }
}
