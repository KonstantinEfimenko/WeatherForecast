//
//  ForcastByCityModuleFactory.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 02.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import DataModel
import DataService

protocol ForecastByCityModuleFactoryProtocol {
    func makeCitiesListModule() -> (presenter: CitiesListPresenterProtocol, vc: Presentable, nav: CitiesListNavigation)?
    func makeForecastModule() -> (presenter: ForecastPresenterProtocol, vc: Presentable, nav: ForecastNavigation)?
}

final class ForecastByCityModuleFactory: ForecastByCityModuleFactoryProtocol {
    
    private let storageManager: StorageManagerProtocol
    
    init(storageManager: StorageManagerProtocol) {
        self.storageManager = storageManager
    }
    
    func makeCitiesListModule() -> (presenter: CitiesListPresenterProtocol, vc: Presentable, nav: CitiesListNavigation)? {
        final class CitiesListNav: CitiesListNavigation {
            var goToForecast: ((City) -> Void)?
        }
        
        let nav = CitiesListNav()
        let presenter = CitiesListPresenter(navigation: nav, storageManager: storageManager)
        if let viewController = CitiesListViewController.make(withPresenter: presenter) {
            return (presenter, viewController, nav)
        } else {
            return nil
        }
    }
    
    func makeForecastModule() -> (presenter: ForecastPresenterProtocol, vc: Presentable, nav: ForecastNavigation)? {
        final class ForecastNav: ForecastNavigation {
        
        }
        
        let nav = ForecastNav()
        let presenter = ForecastPresenter(navigation: nav, storageManager: storageManager)
        if let viewController = ForecastViewController.make(withPresenter: presenter) {
            presenter.managedView = viewController
            return (presenter, viewController, nav)
        } else {
            return nil
        }
    }
}
