//
//  main.swift
//  LensGenerator
//
//  Created by Alexandru Culeva on 10/12/16.
//  Copyright © 2016 Alexandru Culeva. All rights reserved.
//

import Foundation
import SourceKittenFramework

let file = File(path: Bundle.main.path(forResource: "test", ofType: "swift")!)
let dictionary = Structure(file: file!).dictionary
let string = Parser(dictionary: dictionary).string

print(string)
