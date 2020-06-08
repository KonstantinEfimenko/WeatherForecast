//
//  CitiesPresenter.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 02.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import DataModel
import DataService
import Foundation

protocol CitiesListNavigation {
    var goToForecast: ((City) -> Void)? { get set }
}

protocol CitiesListPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    
    var numberOfCities: Int { get }
    func city(at index: Int) -> City?
    func didSelectCity(at index: Int)
}

protocol CitiesListViewProtocol: AnyObject {
    func reloadTableView()
}

class CitiesListPresenter: CitiesListPresenterProtocol {
    
    weak var managedView: CitiesListViewProtocol?
    private let navigation: CitiesListNavigation
    private let storageManager: StorageManagerProtocol
    private var cities: [City]?
    
    init(navigation: CitiesListNavigation, storageManager: StorageManagerProtocol) {
        self.navigation = navigation
        self.storageManager = storageManager
    }
    
    func viewDidLoad() {
        storageManager.getCities { [weak self] cities in
            self?.cities = cities
            self?.managedView?.reloadTableView()
        }
    }
    
    var numberOfCities: Int {
        return cities?.count ?? 0
    }
    
    func city(at index: Int) -> City?{
        return cities?[safe: index]
    }
    
    func didSelectCity(at index: Int) {
        guard let city = cities?[safe: index] else {
            return
        }
        navigation.goToForecast?(city)
    }
}
