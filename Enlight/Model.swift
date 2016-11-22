//
//  Model.swift
//  LensGenerator
//
//  Created by Alexandru Culeva on 10/15/16.
//  Copyright © 2016 Alexandru Culeva. All rights reserved.
//

import Foundation

public struct Model {
    let name: String
    let type: String
    
    init?(dictionary: SKDictionary) {
        guard let type = (dictionary["key.typename"] ?? dictionary["key.kind"]) as? String,
            let name = dictionary["key.name"] as? String else { return nil }
        self.name = name
        self.type = type
    }
}
