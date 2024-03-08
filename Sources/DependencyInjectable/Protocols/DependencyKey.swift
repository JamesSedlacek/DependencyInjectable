//
//  DependencyKey.swift
//
//  Created by James Sedlacek on 3/6/24.
//

import Foundation

/// A protocol for defining keys for dependency injection.
///
/// `DependencyKey` is used in conjunction with `DependencyValues` to provide a type-safe
/// mechanism for storing and retrieving dependencies. Each key defines the type of value
/// it represents and specifies a default value. This default value is used when no explicit
/// value has been set for the key, ensuring that the system remains robust and that
/// dependencies can always be resolved.
///
/// Usage:
/// To define a new dependency, create a struct that conforms to `DependencyKey` and specify
/// the associated type and default value. This key can then be used to access the dependency
/// within `DependencyValues`.
///
/// ```
/// struct MyDependencyKey: DependencyKey {
///     typealias Value = MyDependencyType
///     static let defaultValue: MyDependencyType = MyDependency()
/// }
/// ```
/// Here, `MyDependencyKey` is used to access `MyDependencyType` instances from the
/// dependency container, providing a clear and type-safe way to manage dependencies.
public protocol DependencyKey {
    /// The type of the dependency value associated with the key.
    associatedtype Value

    /// The default value for the dependency.
    ///
    /// This value is used when no explicit value has been set for the dependency key,
    /// ensuring that the system can always provide a value for the dependency.
    static var defaultValue: Self.Value { get }
}
