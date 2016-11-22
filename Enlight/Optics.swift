//
//  Optics.swift
//  LensGenerator
//
//  Created by Alexandru Culeva on 10/12/16.
//  Copyright © 2016 Alexandru Culeva. All rights reserved.
//

import Foundation

protocol OpticalType {
    associatedtype Source
    associatedtype Target
}

protocol LensType: OpticalType {
    var get: (Source) -> Target { get }
    var set: (Target, Source) -> Source { get }
}

protocol PrismType: OpticalType {
    var get: (Source) -> Target? { get }
    var set: (Target) -> Source { get }
}

struct Lens<S, T>: LensType {
    typealias Source = S
    typealias Target = T
    
    let get: (S) -> T
    let set: (T, S) -> S
}

struct Prism<S, T>: PrismType {
    typealias Source = S
    typealias Target = T
    
    let get: (S) -> T?
    let set: (T) -> S
}

extension PrismType {
    func compose<Other: PrismType>(_ other: Other) -> Prism<Self.Source, Other.Target> where Self.Target == Other.Source {
        return Prism<Self.Source, Other.Target>(
            get: { self.get($0).flatMap(other.get) },
            set: { self.set(other.set($0)) }
        )
    }
}

extension LensType {
    func compose<Other: LensType>(_ other: Other) -> Lens<Self.Source, Other.Target> where Self.Target == Other.Source {
        return Lens<Self.Source, Other.Target>(
            get: { other.get(self.get($0)) },
            set: { self.set(other.set($0, self.get($1)), $1) }
        )
    }
}
