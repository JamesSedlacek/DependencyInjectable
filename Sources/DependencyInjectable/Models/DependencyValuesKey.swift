//
//  DependencyValuesKey.swift
//
//  Created by James Sedlacek on 3/6/24.
//

import SwiftUI

/// A key for accessing `DependencyValues` within SwiftUI's `EnvironmentValues`.
///
/// This struct conforms to `EnvironmentKey`, a protocol used to define keys for
/// accessing values stored in the environment. `DependencyValuesKey` is designed
/// to provide access to a `DependencyValues` instance, which acts as a container
/// for dependencies needed throughout a SwiftUI application. By leveraging the
/// environment, dependencies can be injected into views in a type-safe manner,
/// promoting a clean and modular architecture.
///
/// Usage:
/// You do not need to interact directly with `DependencyValuesKey`. Instead, use
/// the `.dependencies` property added to `EnvironmentValues` by the extension
/// in `EnvironmentValues+Dependencies.swift`. This approach abstracts away the
/// direct handling of the environment key, simplifying dependency injection.
public struct DependencyValuesKey: EnvironmentKey {
    /// The default value for `DependencyValuesKey`.
    ///
    /// When accessing `DependencyValues` in the environment without a prior explicit
    /// value being set, this default instance is used. It ensures that there's always
    /// a valid `DependencyValues` instance available, facilitating the seamless injection
    /// and retrieval of dependencies within the app's views.
    public static let defaultValue = DependencyValues()
}
