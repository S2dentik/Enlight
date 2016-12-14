//
//  TestFile.swift
//  Enlight
//
//  Created by Alexandru Culeva on 12/13/16.
//  Copyright © 2016 Alexandru Culeva. All rights reserved.
//

import Foundation

enum TestFile {
    case simpleStructWithNoCustomInit
    
    var path: String {
        switch self {
        case .simpleStructWithNoCustomInit:
            return path(for: "SimpleStructWithNoCustomInit")
        }
    }
    
    var output: String {
        switch self {
        case .simpleStructWithNoCustomInit:
            return try! String(contentsOfFile: path(for: "SimpleStructWithNoCustomInitOutput"))
        }
    }
    
    private func path(for file: String) -> String {
        return currentBundle.path(forResource: file, ofType: "swift")!
    }
}

