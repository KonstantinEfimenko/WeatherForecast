//
//  RouterProtocol.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 03.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import UIKit

protocol RouterProtocol: AnyObject {
        
    func push(_ module: Presentable?)
    
    func setRootModule(_ module: Presentable?)
}
