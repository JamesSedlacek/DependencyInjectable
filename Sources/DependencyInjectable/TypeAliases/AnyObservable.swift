//
//  AnyObservable.swift
//
//  Created by James Sedlacek on 3/6/24.
//

import Foundation

/// Represents an observable object in SwiftUI.
///
/// `AnyObservable` is a typealias for any class (reference type) that also conforms to the
/// `Observable` protocol. This combination is essential for SwiftUI's reactive architecture,
/// allowing views to observe and respond to changes in these objects. Observable objects
/// notify the SwiftUI framework when their properties change, triggering updates in the UI
/// to reflect the new state.
///
/// Usage:
/// Use `AnyObservable` to specify that a type is both a reference type and observable within
/// SwiftUI. This is particularly useful when defining protocols or classes intended for use
/// with SwiftUI's environment, dependency injection, or data binding systems.
///
/// ```
/// class MyModel: AnyObservable {
///     @Published var data: String = ""
///
///     // Implementation details...
/// }
/// ```
/// Here, `MyModel` conforms to `AnyObservable` by being a class that also adheres to
/// SwiftUI's `ObservableObject` protocol (through the use of `@Published` properties).
/// This makes `MyModel` suitable for use in SwiftUI views that need to react to changes
/// in `data`.
public typealias AnyObservable = AnyObject & Observable
