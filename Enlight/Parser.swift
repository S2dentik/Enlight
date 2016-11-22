//
//  Parser.swift
//  LensGenerator
//
//  Created by Alexandru Culeva on 10/12/16.
//  Copyright © 2016 Alexandru Culeva. All rights reserved.
//

import Foundation
import SourceKittenFramework

public struct Parser {
    private let dictionary: [String: SourceKitRepresentable]
    
    public init?(path: String) {
        guard let file = File(path: path) else {
            print("File at \(path) doesn't exist")
            return nil
        }
        dictionary = Structure(file: file).dictionary
    }
    
    public var json: JSON<Model>? {
        return JSON<Model>.modelPrism.get(dictionary)
    }
    
    public var string: String {
        return json.flatMap { self.string(for: $0) } ?? ""
    }
    
    private func string(for json: JSON<Model>) -> String {
        switch json {
        case .array(let array): return array.map { self.string(for: $0) }.joined(separator: "\n\n")
        case .dictionary(let dictionary):
            let data: (key: String, models: [Model])? = dictionary.first.apply { (key, json) in
                guard case let .array(array) = json else { return nil }
                let models: [Model] = array.flatMap {
                    guard case let .child(model) = $0 else { return nil }
                    return model
                }
                return (key, models)
            }
            return data.apply { data in lens(container: data.key, models: data.models) } ?? ""
        default: return ""
        }
    }
}

func lens(container: String, models: [Model]) -> String {
    return "extension \(container) {" + newLine +
        models.map { lens(container: container, models: models, name: $0.name, tabs: 1) }.joined(separator: "\n\n") + newLine +
    "}"
}

func lens(container: String, models: [Model], name: String, tabs: Int = 0) -> String {
    guard let currentModel = models.lazy.filter({ $0.name == name }).first else { return "" }
    let setterInit = "\(container)(\(models.map { $0.name + ": " + ($0.name == name ? "$0" : "$1.\($0.name)") }.joined(separator: ", ") + ")")"
    return tabS(tabs) + "static var \(name)Lens: Lens<\(container), \(currentModel.type)> {" + newLine +
        tabS(tabs + 1) + "return Lens<\(container), \(currentModel.type)>(" + newLine +
        tabS(tabs + 2) + "get: { $0.\(currentModel.name) }," + newLine +
        tabS(tabs + 2) + "set: { \(setterInit) }" + newLine +
        tabS(tabs + 1) + ")" + newLine +
    tabS(tabs) + "}"
}

func tabS(_ tabs: Int = 0) -> String {
    return tab * tabs
}

struct Struct {
    let string: String
    let data: Data
    let int: Int
    let double: Double
    let other: Other
    let `class`: Class
}

struct Other {
    let float: Float
    let bool: Bool
}

class Class {
    let other: Other
    let `struct`: Struct
    
    init(other: Other, `struct`: Struct) {
        self.other = other
        self.`struct` = `struct`
    }
}

extension Struct {
    static var stringLens: Lens<Struct, String> {
        return Lens<Struct, String>(
            get: { $0.string },
            set: { Struct(string: $0, data: $1.data, int: $1.int, double: $1.double, other: $1.other, class: $1.`class`) }
        )
    }
    
    static var dataLens: Lens<Struct, Data> {
        return Lens<Struct, Data>(
            get: { $0.data },
            set: { Struct(string: $1.string, data: $0, int: $1.int, double: $1.double, other: $1.other, class: $1.`class`) }
        )
    }
}
