//
//  main.swift
//  LensGenerator
//
//  Created by Alexandru Culeva on 10/12/16.
//  Copyright © 2016 Alexandru Culeva. All rights reserved.
//

import Foundation
import Enlight

let path = Bundle.main.path(forResource: "test", ofType: "swift")!
let string = Parser(path: path)!.string

print(string)
