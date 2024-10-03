//
//  DragGesture.swift
//  SwiftUIEx
//
//  Created by Daniel Fortes on 21/09/24.
//

import SwiftUI

public extension View {
    func dragGesture(
        coordinateSpace: some CoordinateSpaceProtocol = .global,
        onStarted: (() -> Void)? = nil,
        onChanged: ((DragGestureModifier.Value) -> Void)? = nil,
        onEnded: ((DragGestureModifier.Value) -> Void)? = nil
    ) -> some View {
        self.modifier(DragGestureModifier(
            onStarted: onStarted,
            onChanged: onChanged,
            onEnded: onEnded,
            handler: nil,
            coordinateSpace: .init(coordinateSpace)
        ))
    }

    func dragGesture(
        coordinateSpace: some CoordinateSpaceProtocol = GlobalCoordinateSpace.global,
        _ handler: @escaping DragGestureHandler
    ) -> some View {
        self.modifier(DragGestureModifier(
            onStarted: nil,
            onChanged: nil,
            onEnded: nil,
            handler: handler,
            coordinateSpace: .init(coordinateSpace)
        ))
    }
}

public enum DragGesturePhase {
    case started
    case changed(value: DragGestureModifier.Value)
    case ended(value: DragGestureModifier.Value)

    public var name: String {
        switch self {
        case .started:
            return "started"
        case .changed:
            return "changed"
        case .ended:
            return "ended"
        }
    }
}

public typealias DragGestureHandler = (DragGesturePhase) -> Void

public struct DragGestureModifier: ViewModifier {
    let onStarted: (() -> Void)?
    let onChanged: ((Self.Value) -> Void)?
    let onEnded: ((Self.Value) -> Void)?
    let handler: DragGestureHandler?
    let coordinateSpace: AnyCoordinateSpace // CoordinateFrame

    @State private var isDragging = false
    @State private var lastTranslation = CGSize.zero

    func onStarted_() {
        if let onStarted = self.onStarted {
            onStarted()
        } else {
            self.handler?(.started)
        }
    }

    func onChanged_(_ value: Self.Value) {
        if let onChanged = self.onChanged {
            onChanged(value)
        } else {
            self.handler?(.changed(value: value))
        }
    }

    func onEnded_(_ value: Self.Value) {
        if let onEnded = self.onEnded {
            onEnded(value)
        } else {
            self.handler?(.ended(value: value))
        }
    }

    public func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture(coordinateSpace: self.coordinateSpace)
                    .onChanged { value in
                        if !self.isDragging {
                            self.isDragging = true
                            self.lastTranslation = .zero
                            self.onStarted_()
                        }

                        let delta = CGSize(
                            width: value.translation.width - self.lastTranslation.width,
                            height: value.translation.height - self.lastTranslation.height
                        )
                        self.lastTranslation = value.translation
                        self.onChanged_(Self.Value(value, delta: delta))
                    }
                    .onEnded { value in
                        let delta = CGSize(
                            width: value.translation.width - self.lastTranslation.width,
                            height: value.translation.height - self.lastTranslation.height
                        )
                        self.onEnded_(Self.Value(value, delta: delta))
                        self.lastTranslation = .zero
                        self.isDragging = false
                    }
            )
    }
}

public extension DragGestureModifier {
    struct Value {
        public var translation: CGSize
        public var velocity: CGSize
        public var location: CGPoint
        public var startLocation: CGPoint
        public var predictedEndLocation: CGPoint
        public var predictedEndTranslation: CGSize
        public var delta: CGSize

        init(_ value: DragGesture.Value, delta: CGSize) {
            self.translation = value.translation
            self.velocity = value.predictedEndTranslation
            self.predictedEndLocation = value.predictedEndLocation
            self.predictedEndTranslation = value.predictedEndTranslation
            self.location = value.location
            self.startLocation = value.startLocation
            self.delta = delta
        }
    }
}
