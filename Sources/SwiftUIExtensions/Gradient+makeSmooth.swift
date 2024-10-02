import Easing
import SwiftUI

public extension Gradient {
    static func makeSmooth(from: Color, to: Color, in environment: EnvironmentValues) -> Gradient {
        var stops: [Gradient.Stop] = [
        ]

        let a = from.resolve(in: environment).cgColor
        let b = to.resolve(in: environment).cgColor

        for i in stride(from: 0, to: 1.01, by: 0.1) {
            let x: Double = EasingCurve.cubic.easeOut(i)
            let color = CGColor.lerp(a, b, x)
            stops.append(.init(color: Color(color), location: i))
        }
        return .init(stops: stops)
    }
}
