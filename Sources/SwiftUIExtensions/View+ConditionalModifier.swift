//
//  View+ConditionalModifier.swift
//  SwiftUIEx
//
//  Created by Daniel Fortes on 23/09/24.
//

import SwiftUI

public extension View {
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
