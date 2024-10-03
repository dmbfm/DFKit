//
//  Color+Dynamic.swift
//  SwiftUIEx
//
//  Created by Daniel Fortes on 23/09/24.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

public extension Color {
    init(light: Color, dark: Color) {
        #if canImport(UIKit)
        self.init(light: UIColor(light), dark: UIColor(dark))
        #else
        self.init(light: NSColor(light), dark: NSColor(dark))
        #endif
    }

    #if canImport(UIKit)
    init(light: UIColor, dark: UIColor) {
        self.init(uiColor: .init(dynamicProvider: { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                dark
            } else {
                light
            }
        }))
    }
    #endif

    #if canImport(AppKit)
    init(light: NSColor, dark: NSColor) {
        self.init(nsColor: NSColor(name: nil) { appearance in
            switch appearance.name {
            case .darkAqua, .vibrantDark, .accessibilityHighContrastDarkAqua,
                 .accessibilityHighContrastVibrantDark:
                dark
            default:
                light
            }
        })
    }
    #endif
}
