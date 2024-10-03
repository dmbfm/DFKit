import CGExtensions
import SwiftUI

extension View {
    /// Adds a drag gesture to the view that updates a views position based on the drag translation.
    ///
    /// - Parameters:
    ///   - position: A binding to the position of the view.
    ///   - translate: An optional closure that takes the start position and
    ///                the drag translation and returns the new position.
    /// - Returns: A view that updates its position based on the drag gesture.
    public func positionDrag(
        _ position: Binding<CGPoint>,
        translate: ((_ startPosition: CGPoint, _ translation: CGSize) -> CGPoint)? = nil
    ) -> some View {
        self.modifier(PositionDrag(position: position, translate: translate))
    }
}

struct PositionDrag {
    @Binding var position: CGPoint
    let translate: ((_ startPosition: CGPoint, _ translation: CGSize) -> CGPoint)?

    @State var isDragging = false
    @State var positionAtDragStart = CGPoint.zero

    init(
        position: Binding<CGPoint>,
        translate: ((_ startPosition: CGPoint, _ translation: CGSize) -> CGPoint)? = nil
    ) {
        self._position = position
        self.translate = translate
    }
}

extension PositionDrag {
    func dragChangedHandler(_ value: DragGesture.Value) {
        if !self.isDragging {
            self.isDragging = true
            self.positionAtDragStart = self.position
        }

        if let translate = self.translate {
            self.position = translate(self.positionAtDragStart, value.translation)
        } else {
            self.position = self.positionAtDragStart + value.translation.cgPoint
        }
    }

    func dragEndedHandler(_: DragGesture.Value) {
        self.isDragging = false
    }
}

extension PositionDrag: ViewModifier {
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture()
                    .onChanged(self.dragChangedHandler)
                    .onEnded(self.dragEndedHandler)
            )
    }
}
