//
//  Color.swift
//  SwiftUIEx
//
//  Created by Daniel Fortes on 23/09/24.
//

import CGExtensions
import SwiftUI

public extension Color {
    func transformHSB(
        in environment: EnvironmentValues,
        _ transform: (inout CGFloat, inout CGFloat, inout CGFloat) -> Void
    ) -> Color {
        Color(cgColor: self.resolve(in: environment).cgColor.transformHSB(transform: transform))
    }

    func mapCGColor(
        in environment: EnvironmentValues,
        _ transform: (CGColor) -> CGColor
    ) -> Color {
        Color(cgColor: transform(self.resolve(in: environment).cgColor))
    }

    func desaturated(by percentage: Double, in environment: EnvironmentValues) -> Color {
        self.mapCGColor(in: environment) { cgColor in
            cgColor.desaturated(by: percentage)
        }
    }

    func dimmed(by percentage: Double, in environment: EnvironmentValues) -> Color {
        self.mapCGColor(in: environment) { cgColor in
            cgColor.dimmed(by: percentage)
        }
    }
}

#Preview("desaturating") {
    struct P: View {
        @Environment(\.self) var environment
        var body: some View {
            VStack {
                Text("Some Text")
                    .font(.headline)
                    .foregroundStyle(Color.red)
                    .padding(80)
            }
            .background { Color.red.desaturated(by: 0.8, in: .init()) }
        }
    }

    return P()
}

#Preview("dimmed") {
    struct P: View {
        @Environment(\.self) var environment
        var body: some View {
            VStack {
                Text("Some Text")
                    .font(.headline)
                    .foregroundStyle(Color.red.dimmed(by: 0.5, in: self.environment))
                    .padding(80)
            }
            .background { Color.red.desaturated(by: 0.8, in: .init()) }
//            .background { Color.red.dimmed(by: 0.8, in: .init()) }
        }
    }

    return P()
}

#Preview("transformHSB") {
    struct P: View {
        @Environment(\.self) var environment
        var body: some View {
            HStack(spacing: 0) {
                Color.red
                Color.red
                    .transformHSB(in: self.environment) { h, _, _ in
                        h += 0.1
                    }
            }
            .frame(width: 200, height: 200)
        }
    }

    return P()
}
