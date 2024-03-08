//
//  EnvironmentValues+Dependencies.swift
//
//  Created by James Sedlacek on 3/6/24.
//

import SwiftUI

/// Extension of `EnvironmentValues` to integrate dependency injection.
///
/// This extension adds a `dependencies` property to `EnvironmentValues`, enabling
/// SwiftUI views to access a `DependencyValues` container. This container can be used
/// to inject dependencies into SwiftUI views, facilitating a modular and testable design
/// by allowing dependencies to be passed through the environment rather than
/// instantiated directly within the views.
///
/// Usage:
/// In your SwiftUI views, you can access your dependencies via the environment, like so:
/// ```
/// @Environment(\.dependencies) var dependencies: DependencyValues
/// ```
/// This makes it easy to access shared resources and services throughout your app.
extension EnvironmentValues {
    public var dependencies: DependencyValues {
        get {
            self[DependencyValuesKey.self]
        }
        set {
            self[DependencyValuesKey.self] = newValue
        }
    }
}
