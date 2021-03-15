//
//  NSObject+.swift
//  Colombia
//
//  Created by Takuma Osada on 2021/03/13.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: self)
    }
}

