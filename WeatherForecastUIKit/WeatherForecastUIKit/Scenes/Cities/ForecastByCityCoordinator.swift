//
//  ForecastByCityCoordinator.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 02.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import DataModel
import DataService
import UIKit

final class ForecastByCityCoordinator: Coordinator {
    
    private var citiesListPresenter: CitiesListPresenter?
    private let factory: ForecastByCityModuleFactoryProtocol
    
    init(router: RouterProtocol, storageManager: StorageManagerProtocol) {
        self.factory = ForecastByCityModuleFactory(storageManager: storageManager)
        
        super.init(router: router)
    }
    
    override func start() -> UIViewController? {
        toCitiesScreen()
        
        return nil
    }
}

extension ForecastByCityCoordinator {
    
    private func toCitiesScreen() {
        
        if var forecastByCityModule = factory.makeCitiesListModule() {
            
            forecastByCityModule.nav.goToForecast = { [weak self] city in
                self?.toForecastScreen(for: city)
            }
            
            router.setRootModule(forecastByCityModule.vc)
        }
    }
    
    private func toForecastScreen(for city: City) {
        
        if let forecastModule = factory.makeForecastModule() {
            forecastModule.presenter.cityName = city.name
            router.push(forecastModule.vc)
        }
    }
}

