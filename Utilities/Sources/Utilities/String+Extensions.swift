//
//  File.swift
//  
//
//  Created by Kostiantyn YEFYMENKO on 05.06.20.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self,
                                 tableName: nil,
                                 bundle: Bundle.main,
                                 value: "",
                                 comment: "")
    }
}
