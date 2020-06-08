//
//  Coordinator.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 03.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import UIKit

class Coordinator: CoordinatorProtocol {
    
    var childCoordinators = NSMutableOrderedSet()
    let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    @discardableResult func start() -> UIViewController? {
        return nil
    }
    
    func addDependency(_ coordinator: CoordinatorProtocol) {
        childCoordinators.add(coordinator)
    }
}
