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
        self.init(lightUiColor: UIColor(light), darkUiColor: UIColor(dark))
        #else
        self.init(lightNsColor: NSColor(light), darkNsColor: NSColor(dark))
        #endif
    }

    #if canImport(UIKit)
    init(lightUiColor: UIColor, darkUiColor: UIColor) {
        self.init(uiColor: .init(dynamicProvider: { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                darkUiColor
            } else {
                lightUiColor
            }
        }))
    }
    #endif

    #if canImport(AppKit)
    init(lightNsColor: NSColor, darkNsColor: NSColor) {
        self.init(nsColor: NSColor(name: nil) { appearance in
            switch appearance.name {
            case .darkAqua, .vibrantDark, .accessibilityHighContrastDarkAqua,
                 .accessibilityHighContrastVibrantDark:
                darkNsColor
            default:
                lightNsColor
            }
        })
    }
    #endif
}
