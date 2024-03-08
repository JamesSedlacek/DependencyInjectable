//
//  DependencyValues.swift
//
//  Created by James Sedlacek on 3/6/24.
//

import SwiftUI

/// A container for dependency injection values.
///
/// `DependencyValues` is a central store for dependencies that are to be injected
/// into SwiftUI views. It uses a type-safe mechanism for storing and retrieving
/// dependencies based on their associated `DependencyKey`. This design allows for
/// flexible, modular, and testable development by decoupling the dependency
/// creation and consumption.
///
/// Usage:
/// To add a new dependency, define a new `DependencyKey` and use the subscript
/// to set and get the value in your app's environment or view hierarchy.
///
/// ```
/// struct MyDependencyKey: DependencyKey {
///     static let defaultValue: MyDependency = MyDependencyImpl()
/// }
///
/// var dependencies = DependencyValues()
/// dependencies[MyDependencyKey.self] = MyCustomDependency()
/// ```
///
/// This example demonstrates how to create a custom dependency and inject it
/// into the `DependencyValues` store.
public struct DependencyValues: CustomStringConvertible {
    /// The storage for dependency values, keyed by their `ObjectIdentifier`.
    private var values: [ObjectIdentifier: Any]

    /// Initializes a new, empty `DependencyValues` container.
    public init() {
        values = [:]
    }

    /// Provides type-safe access to dependency values based on their keys.
    ///
    /// - Parameter key: The `DependencyKey` type used to access the dependency.
    /// - Returns: The dependency value associated with the key, or the key's
    ///   `defaultValue` if no value is set.
    public subscript<Key: DependencyKey>(key: Key.Type) -> Key.Value {
        get {
            let id = ObjectIdentifier(key)
            return values[id] as? Key.Value ?? Key.defaultValue
        }
        set(newValue) {
            let id = ObjectIdentifier(key)
            values[id] = newValue
        }
    }

    /// A string representation of the `DependencyValues` instance, conforming to `CustomStringConvertible`.
    public var description: String {
        "DependencyValues contains \(values.count) dependencies."
    }
}
