//
//  ForecastPresenter.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 02.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import DataModel
import DataService
import Foundation

protocol ForecastNavigation { }

protocol ForecastPresenterProtocol: AnyObject {
    var managedView: ForecastViewProtocol? { get set }
    var cityName: String? { get set }
    var numberOfItems: Int { get }
    
    func viewDidLoad()
    func dayForecast(at row: Int) -> DayForecast?
}

protocol ForecastViewProtocol: AnyObject {
    func set(title: String?)
    func reloadTableView()
    func showSpinner(_ show: Bool)
    func showError(with message: String)
}

class ForecastPresenter: ForecastPresenterProtocol {
    
    var cityName: String?
    weak var managedView: ForecastViewProtocol?
    private let navigation: ForecastNavigation
    private let storageManager: StorageManagerProtocol
    private var dayForecasts: [DayForecast]? {
        didSet {
            managedView?.reloadTableView()
        }
    }
    
    init(navigation: ForecastNavigation, storageManager: StorageManagerProtocol) {
        self.navigation = navigation
        self.storageManager = storageManager
    }
    
    var numberOfItems: Int {
        dayForecasts?.count ?? 0
    }
    
    func viewDidLoad() {
        managedView?.set(title: cityName)
        managedView?.showSpinner(true)
        storageManager.getForecast(by: cityName ?? "") { [weak self] result in
            switch result {
            case .success(let list):
                self?.dayForecasts = list                
            case .failure(let error):
                self?.managedView?.showError(with: error.localizedDescription)
            }
            self?.managedView?.showSpinner(false)
        }
    }
    
    func dayForecast(at row: Int) -> DayForecast? {
        dayForecasts?[safe: row]
    }
}
