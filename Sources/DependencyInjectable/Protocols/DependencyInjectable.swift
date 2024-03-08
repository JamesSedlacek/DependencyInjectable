//
//  DependencyInjectable.swift
//
//  Created by James Sedlacek on 3/6/24.
//

import Foundation

/// A protocol defining an injectable dependency.
///
/// Types conforming to `DependencyInjectable` can be injected with dependencies
/// from a `DependencyValues` container. This protocol is designed to facilitate
/// dependency injection in a modular and decoupled way, allowing objects to be
/// configured with their necessary dependencies at the time of injection.
///
/// Usage:
/// Implement the `onInject(dependencies:)` method in your conforming type to handle
/// the injection of dependencies. This method provides an opportunity to configure
/// the object with dependencies retrieved from the provided `DependencyValues`.
///
/// ```
/// class MyService: DependencyInjectable {
///     var anotherService: AnotherServiceType?
///
///     func onInject(dependencies: DependencyValues) {
///         self.anotherService = dependencies[AnotherServiceKey.self]
///     }
/// }
/// ```
/// In this example, `MyService` conforms to `DependencyInjectable` and uses the
/// `onInject` method to configure itself with `AnotherServiceType` from the
/// dependency container.
public protocol DependencyInjectable {
    /// Called when dependencies are injected into the conforming object.
    ///
    /// - Parameter dependencies: The `DependencyValues` container from which the object
    ///   can retrieve its dependencies.
    func onInject(dependencies: DependencyValues)
}
