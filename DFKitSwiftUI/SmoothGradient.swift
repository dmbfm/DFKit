import SwiftUI

/// A shape style that fills a shape with a smooth gradient between two colors.
public struct SmoothGradient: Sendable {
    var from: Color
    var to: Color
    var startPoint: UnitPoint
    var endPoint: UnitPoint

    /// Creates a smooth gradient between two colors.
    /// - Parameters:
    ///   - from: The starting color.
    ///   - to: The ending color.
    ///   - startPoint: The starting point of the gradient.
    ///   - endPoint: The ending point of the gradient.
    public init(from: Color, to: Color, startPoint: UnitPoint = .top, endPoint: UnitPoint = .bottom) {
        self.from = from
        self.to = to
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
}

public extension ShapeStyle where Self == SmoothGradient {
    /// Creates a smooth gradient between two colors.
    /// - Parameters:
    ///   - from: The starting color.
    ///   - to: The ending color.
    ///   - startPoint: The starting point of the gradient.
    ///   - endPoint: The ending point of the gradient.
    static func smoothGradient(from: Color, to: Color, startPoint: UnitPoint = .top, endPoint: UnitPoint = .bottom) -> SmoothGradient {
        SmoothGradient(from: from, to: to, startPoint: startPoint, endPoint: endPoint)
    }
}

extension SmoothGradient: ShapeStyle {
    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        LinearGradient(gradient: Gradient.makeSmooth(from: self.from, to: self.to, in: environment), startPoint: self.startPoint, endPoint: self.endPoint)
    }
}

extension SmoothGradient: View {
    public var body: some View {
        Rectangle().fill(self)
    }
}

#Preview {
    struct P: View {
        @Environment(\.colorScheme) var colorScheme
        var body: some View {
            HStack {
                Rectangle()
                    .fill(SmoothGradient(from: Color(light: Color.red, dark: Color.yellow), to: .blue))
                    .frame(width: 200, height: 200)

                Rectangle()
                    .fill(.linearGradient(colors: [Color(light: Color.red, dark: Color.yellow), .blue], startPoint: .top, endPoint: .bottom))
                    // .fill(SmoothGradient(from: Color(light: Color.red, dark: Color.yellow), to: .blue))
                    .frame(width: 200, height: 200)
            }
        }
    }

    return P()
}
