//
//  OptionalExtensions.swift
//  LensGenerator
//
//  Created by Alexandru Culeva on 10/13/16.
//  Copyright © 2016 Alexandru Culeva. All rights reserved.
//

import Foundation

extension Optional {
    func apply<T>(f: (Wrapped) -> T?) -> T? {
        return flatMap(f)
    }
}

extension Optional: CustomStringConvertible {
    public var description: String {
        guard case let .some(some) = self else { return "nil" }
        return String(describing: some)
    }
    
    var debugDescription: String {
        return description
    }
}
