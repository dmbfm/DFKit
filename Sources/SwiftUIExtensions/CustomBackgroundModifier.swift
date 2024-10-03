import SwiftUI

public enum CustomBackground {
    case none
    case shapeStyle(AnyShapeStyle)
    case view(AnyView)
}

public extension EnvironmentValues {
    @Entry var customBackgroundStyle: CustomBackground = .none
}

public struct CustomBackgroundModifier: ViewModifier {
    var background: Environment<CustomBackground>

    public init(_: KeyPath<EnvironmentValues, CustomBackground>) {
        background = Environment(\.customBackgroundStyle)
    }

    public func body(content: Content) -> some View {
        switch background.wrappedValue {
        case let .shapeStyle(shapeStyle):
            content.background(shapeStyle)
        case let .view(view):
            content.background { view }
        case .none:
            content
        }
    }
}

public extension CustomBackgroundModifier {
    static func customBackground<V: View>(_ view: V, _ keyPath: WritableKeyPath<EnvironmentValues, CustomBackground>, _ style: CustomBackground) -> some View {
        view.environment(keyPath, style)
    }

    static func customBackground<V: View>(_ view: V, _ keyPath: WritableKeyPath<EnvironmentValues, CustomBackground>, @ViewBuilder _ content: () -> V) -> some View {
        view.environment(keyPath, .view(AnyView(content())))
    }

    static func customBackground<V: View, S: ShapeStyle>(_ view: V, _ keyPath: WritableKeyPath<EnvironmentValues, CustomBackground>, _ s: S) -> some View {
        view.environment(keyPath, .shapeStyle(.init(s)))
    }
}
