@attached(member, names: arbitrary)
public macro CaseValueUnwrappedAccessor() = #externalMacro(module: "DFKitMacros", type: "CaseValueUnwrappedAccessorMacro")

@attached(member, names: arbitrary)
public macro CustomBackgroundViewExtension(_ name: String, _ kp: String) = #externalMacro(module: "DFKitMacros", type: "CustomBackgroundViewExtensionMacro")
