import DFKitCoreGraphics
import DFKitEasing
import SwiftUI

public extension Gradient {
    /// Creates a smooth gradient between two colors, using a cubic ease-out curve.
    ///
    /// - Parameters:
    ///   - from: The starting color.
    ///   - to: The ending color.
    ///   - environment: The environment values.
    static func makeSmooth(from: Color, to: Color, in environment: EnvironmentValues) -> Gradient {
        let a = from.resolve(in: environment).cgColor
        let b = to.resolve(in: environment).cgColor

        return self.makeSmooth(from: a, to: b)
    }

    /// Creates a smooth gradient between two colors, using a cubic ease-out curve.
    /// - Parameters:
    ///   - from: The starting color.
    ///   - to: The ending color.
    static func makeSmooth(from: CGColor, to: CGColor) -> Gradient {
        var stops: [Gradient.Stop] = [
        ]

        for i in stride(from: 0, to: 1.01, by: 0.1) {
            let x: Double = EasingCurve.cubic.easeOut(i)
            let color = CGColor.lerp(from, to, x)
            stops.append(.init(color: Color(cgColor: color), location: i))
        }
        return .init(stops: stops)
    }
}
