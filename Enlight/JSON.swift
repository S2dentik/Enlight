//
//  JSON.swift
//  LensGenerator
//
//  Created by Alexandru Culeva on 10/14/16.
//  Copyright © 2016 Alexandru Culeva. All rights reserved.
//

import Foundation
import SourceKittenFramework

public indirect enum JSON<T> {
    case child(T)
    case array([JSON<T>])
    case dictionary([String: JSON<T>])
}

typealias SKDictionary = [String: SourceKitRepresentable]

extension JSON {
    static var modelPrism: Prism<SKDictionary, JSON<Model>> {
        let get: (SKDictionary) -> JSON<Model>? = { dictionary in
            let model = Model(dictionary: dictionary)
            return dictionary["key.substructure"].apply { $0 as? [SKDictionary] }.apply { array in
                let jsonArray: JSON<Model> = .array(array.flatMap { JSON.modelPrism.get($0) })
                return model.apply { .dictionary([$0.name: jsonArray]) } ?? jsonArray
            } ?? model.apply { .child($0) }
        }
        let set: (JSON<Model>) -> SKDictionary = { json in SKDictionary() }
        return Prism<SKDictionary, JSON<Model>>(
            get: get,
            set: set
        )
    }
}

extension JSON: CustomDebugStringConvertible {
    public var debugDescription: String {
        return recursiveDescription(tabs: 0)
    }
    
    private var tab: String { return "  " }
    
    private func recursiveDescription(tabs: Int) -> String {
        let strings: [String] = {
            switch self {
            case .child(let object):
                return [String(describing: object) + ""]
            case .array(let array):
                return ["[\n" + array.map { $0.recursiveDescription(tabs: tabs + 1) }.joined(separator: ",\n") + "\n", "]"]
            case .dictionary(let dictionary):
                return [dictionary.map { (key, value) in key + ":" + value.recursiveDescription(tabs: tabs) }.joined(separator: "")]
            }
        }()
        return strings.map { tab * tabs + $0 }.joined(separator: "")
    }
}
