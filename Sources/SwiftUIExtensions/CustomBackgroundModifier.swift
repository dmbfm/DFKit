import SwiftUI

/// A custom background type that can be used to apply various background styles to views.
///
/// This enum provides three cases:
/// - `none`: No background is applied.
/// - `shapeStyle`: A background is applied using an `AnyShapeStyle`.
/// - `view`: A background is applied using an `AnyView`.
public enum CustomBackground {
    /// No background is applied.
    case none
    /// A background is applied using an `AnyShapeStyle`.
    case shapeStyle(AnyShapeStyle)
    /// A background is applied using an `AnyView`.
    case view(Alignment, AnyView)
}

/// A view modifier that applies a custom background to a view based on an environment value.
///
/// This modifier uses the `CustomBackground` enum to determine the type of background to apply:
/// - If the background is a shape style, it applies it directly to the content.
/// - If the background is a view, it wraps the content in that view.
/// - If no background is specified, it returns the content unchanged.
///
/// The background type is determined by the environment value specified by the key path provided during initialization.
public struct CustomBackgroundModifier: ViewModifier {
    var background: Environment<CustomBackground>

    /// Initializes a new instance of `CustomBackgroundModifier` with the specified key path.
    ///
    /// - Parameter keyPath: A key path to a `CustomBackground` value in the environment.
    ///
    /// This initializer creates a new `CustomBackgroundModifier` that will use the `CustomBackground`
    /// value from the environment specified by the given key path to determine how to apply the background.
    public init(_ keyPath: KeyPath<EnvironmentValues, CustomBackground>) {
        self.background = Environment(keyPath)
    }

    public func body(content: Content) -> some View {
        switch self.background.wrappedValue {
        case let .shapeStyle(shapeStyle):
            content.background(shapeStyle)
        case let .view(alignment, view):
            content.background(alignment: alignment) { view }
        case .none:
            content
        }
    }
}

public extension CustomBackgroundModifier {
    /// Stores a `CustomBackground` value in the environment using the specified key path.
    /// - Parameters:
    ///   - view: The view to apply the environment value to.
    ///   - keyPath: A key path to a `CustomBackground` value in the environment.
    ///   - style: The `CustomBackground` value to store in the environment.
    /// - Returns: A view that applies the specified environment value to the given view.
    static func customBackground<V: View>(_ view: V, _ keyPath: WritableKeyPath<EnvironmentValues, CustomBackground>, _ style: CustomBackground) -> some View {
        view.environment(keyPath, style)
    }

    /// Stores a `CustomBackground.view` value in the environment using the specified key path.
    /// - Parameters:
    ///   - view: The view to apply the environment value to.
    ///   - keyPath: A key path to a `CustomBackground` value in the environment.
    ///   - content: A closure that returns the view to use as the background.
    /// - Returns: A view that applies the specified environment value to the given view.
    static func customBackground<V: View>(
        _ view: V,
        _ keyPath: WritableKeyPath<EnvironmentValues, CustomBackground>,
        alignment: Alignment = .center,
        @ViewBuilder _ content: () -> V
    ) -> some View {
        view.environment(keyPath, .view(alignment, AnyView(content())))
    }

    /// Stores a `CustomBackground.shapeStyle` value in the environment using the specified key path.
    /// - Parameters:
    ///   - view: The view to apply the environment value to.
    ///   - keyPath: A key path to a `CustomBackground` value in the environment.
    ///   - s: The shape style to use as the background.
    /// - Returns: A view that applies the specified environment value to the given view.
    static func customBackground<V: View, S: ShapeStyle>(_ view: V, _ keyPath: WritableKeyPath<EnvironmentValues, CustomBackground>, _ s: S) -> some View {
        view.environment(keyPath, .shapeStyle(.init(s)))
    }
}
