//
//  Operators.swift
//  LensGenerator
//
//  Created by Alexandru Culeva on 10/14/16.
//  Copyright © 2016 Alexandru Culeva. All rights reserved.
//

import Foundation

func *(lhs: String, rhs: Int) -> String {
    return [String](repeating: lhs, count: rhs).joined(separator: "")
}
