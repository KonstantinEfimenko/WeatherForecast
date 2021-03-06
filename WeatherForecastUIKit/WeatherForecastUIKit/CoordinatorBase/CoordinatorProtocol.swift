//
//  CoordinatorProtocol.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 03.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    @discardableResult func start() -> UIViewController?
    var router: RouterProtocol { get }
}
