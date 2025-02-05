// Sources/app/main.swift
import AppKit
import DFKit
import SwiftUI

@main
struct MyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

struct MainView: View {
    @State var desturation: CGFloat = 0.5

    @Environment(\.self) var environment

    var foregroundColor: Color {
        Color.purple
    }

    var foregroundDark: Color {
        self.foregroundColor.mapCGColor(in: self.environment) { cgColor in
            var hsl = HSL(cgColor: cgColor)!
            // hsl.lightness *= (1.0 - max(min(self.desturation, 1.0), 0.0))
            hsl.lightness = 1.0 - self.desturation // (1.0 - max(min(self.desturation, 1.0), 0.0))
            return hsl.cgColor
        }
    }

    // var foregroundLight: Color {
    //     self.foregroundColor.desaturated(by: self.desturation, in: self.environment)
    // }

    var foregroundLight: Color {
        self.foregroundColor.mapCGColor(in: self.environment) { cgColor in
            var hsl = HSL(cgColor: cgColor)!
            // hsl.lightness *= (1.0 + max(min(self.desturation, 1.0), 0.0))
            hsl.lightness = self.desturation // (1.0 + max(min(self.desturation, 1.0), 0.0))
            return hsl.cgColor
        }
    }

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Rectangle()
                    .fill(SmoothGradient(from: self.foregroundLight, to: Color.white))

                Rectangle()
                    .fill(SmoothGradient(from: self.foregroundDark, to: Color.black))
            }

            HStack {
                Stepper("Desaturation: \(self.desturation)", value: self.$desturation, in: 0 ... 1, step: 0.05)
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_: Notification) {
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
        NSApp.windows.first?.makeKeyAndOrderFront(nil)
    }
}
