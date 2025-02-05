//
//  View+ConditionalModifier.swift
//  SwiftUIEx
//
//  Created by Daniel Fortes on 23/09/24.
//

import SwiftUI

public extension View {
    /// Apply a modifier to the view only if a condition is met.
    /// - Parameters:
    ///   - condition: The condition to be met.
    ///   - modifier: The modifier to apply.
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        then modifier: (Self) -> Content
    ) -> some View {
        if condition {
            modifier(self)
        } else {
            self
        }
    }
}

#Preview {
    struct P: View {
        @State private var isToggled = false
        var body: some View {
            VStack {
                Text("Some Text")
                    .font(.headline)
                    .foregroundStyle(Color.red)
                    .padding(80)
                Toggle("Toggle", isOn: $isToggled)
            }
            .background { Color.red.desaturated(by: 0.8, in: .init()) }
            .if(isToggled) { view in
                view
                    .padding(20)
                    .background(Color.blue)
            }
        }
    }

    return P()
}
