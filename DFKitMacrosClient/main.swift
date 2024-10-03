import DFKit
import SwiftUI

extension EnvironmentValues {
    @Entry var nodeBackgroundKeyPath: CustomBackground = .none
}

@CustomBackgroundViewExtension("nodeBackground", "nodeBackgroundKeyPath")
extension View {}

let view = EmptyView().nodeBackground(.red)

dump(view)
