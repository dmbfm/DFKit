public protocol Updatable {}

public extension Updatable {
    func with<V>(keyPath: WritableKeyPath<Self, V>, _ value: V) -> Self {
        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }
}
