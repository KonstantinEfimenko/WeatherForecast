//
//  ReusableView.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 03.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import UIKit

protocol ReusableView {
    static var reuseKey: String { get }
    static var nib: UINib { get }
}

extension ReusableView {
    static var reuseKey: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: reuseKey, bundle: .current)
    }
}

extension UITableViewCell: ReusableView { }
