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
    ///
    /// - Parameter value: A coordinate space to wrap.
    public init(_ value: CoordinateSpaceProtocol) {
        self.value = value
    }

    /// Returns the corresponding `CoordinateSpace` value.
    public var coordinateSpace: CoordinateSpace {
        self.value.coordinateSpace
    }

    /// Represents the global coordinate space.
    public static var global: AnyCoordinateSpace {
        AnyCoordinateSpace(.global)
    }

    /// Represents a named coordinate space.
    public static func named<T>(_ name: T) -> AnyCoordinateSpace where T: Hashable {
        AnyCoordinateSpace(.named(name))
    }
}
