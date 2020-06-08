//
//  ApplicationCoordinator.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 02.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import DataService
import UIKit

final class ApplicationCoordinator: Coordinator {
    
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let storageManager: StorageManagerProtocol
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, storageManager: StorageManagerProtocol) {
        self.coordinatorFactory = coordinatorFactory
        self.storageManager = storageManager
        
        super.init(router: router)
    }
    
    override func start() -> UIViewController? {
        runForecastByCityFlow()
        return nil
    }
    
    private func runForecastByCityFlow() {
        let coordinator = coordinatorFactory.makeForecastByCityCoordinator(router: router, storageManager: storageManager)
        addDependency(coordinator)
        
        coordinator.start()
    }
}
