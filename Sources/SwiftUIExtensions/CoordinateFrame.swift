//
//  CoordinateFrame.swift
//  SwiftUIEx
//
//  Created by Daniel Fortes on 24/09/24.
//

import SwiftUI

/// A type-erased coordinate space.
public struct AnyCoordinateSpace: CoordinateSpaceProtocol {
    
    private var value: any CoordinateSpaceProtocol
    
    /// Creates a type-erased coordinate space that wraps the given instance.
    public init(_ value: CoordinateSpaceProtocol) {
        self.value = value
    }
    
    public var coordinateSpace: CoordinateSpace {
        value.coordinateSpace
    }
}

//public enum CoordinateFrameName {
//    case int(Int)
//    case string(String)
//}
//
//public enum CoordinateFrame: CoordinateSpaceProtocol {
//    case global
//    case local
//    case named(CoordinateFrameName)
//
//    public var coordinateSpace: CoordinateSpace {
//        switch self {
//        case .global:
//            .global
//        case .local:
//            .local
//        case let .named(name):
//            switch name {
//            case let .int(int):
//                .named(int)
//            case let .string(string):
//                .named(string)
//            }
//        }
//    }
//}
//
//public extension CoordinateSpace {
//    var coordinateFrame: CoordinateFrame {
//        switch self {
//        case .global:
//            CoordinateFrame.global
//        case .local:
//            CoordinateFrame.local
//        case .named(let value):
//            CoordinateFrame.named(.int(value.hashValue))
//        @unknown default:
//            fatalError("Unknown CoordinateSpace")
//        }
//    }
//}
