//
//  Binding+CasePathable.swift
//  SwiftUIEx
//
//  Created by Daniel Fortes on 25/09/24.
//

// import SwiftUI
// @_exported import CasePaths
//
// @MainActor
// public extension Binding {
//     subscript<Case>(dynamicMember keyPath: CaseKeyPath<Value, Case>) -> Binding<Case>?
//         where Value: CasePathable
//     {
//         Binding<Case>() {
//             self.wrappedValue[case: keyPath]!
//         } set: { newValue, transaction in
//             self.transaction(transaction).wrappedValue[case: keyPath] = newValue
//         }
//     }
// }
