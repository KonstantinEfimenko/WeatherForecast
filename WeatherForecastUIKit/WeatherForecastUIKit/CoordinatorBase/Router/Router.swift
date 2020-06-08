//
//  Router.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 03.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import UIKit

final class Router: NSObject, RouterProtocol {
    
    var rootController: UINavigationController
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        super.init()
        rootController.delegate = self
    }
    
    func push(_ module: Presentable?) {
        guard let controller = module?.toPresent(), controller is UINavigationController == false else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }
        
        rootController.pushViewController(controller, animated: true)
    }
}

extension Router: UINavigationControllerDelegate {
    func setRootModule(_ module: Presentable?) {
        guard let controller = module?.toPresent() else {
            return
        }
        rootController.setViewControllers([controller], animated: true)
        controller.view.layoutIfNeeded()
    }
}
