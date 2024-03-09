//
//  View+Inject.swift
//
//  Created by James Sedlacek on 3/6/24.
//

import SwiftUI

/// Extension for `View` to enable easy dependency injection.
///
/// Provides methods for injecting dependencies into SwiftUI views. These dependencies
/// are expected to conform to `DependencyInjectable` and either `AnyObservable` or
/// `AnyObservableObject`, facilitating their integration into the SwiftUI's data flow.
///
/// Usage:
/// ```
/// struct ContentView: View {
///     @State var viewModel: ViewModel = .init()
///
///     var body: some View {
///         Text("Hello, World!")
///             .inject(viewModel)
///     }
/// }
/// ```
/// The `inject` method simplifies the injection process, promoting a clean and modular
/// architecture by allowing views to be easily composed with their dependencies.
extension View {
    /// Injects an `AnyObservable` conforming object into the view.
    @available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
    public func inject<T: DependencyInjectable & AnyObservable>(_ object: T) -> some View {
        modifier(ObservableInjectingModifier(object: object))
    }

    /// Injects an `AnyObservableObject` conforming object into the view.
    public func inject<T: DependencyInjectable & AnyObservableObject>(_ object: T) -> some View {
        modifier(ObservableObjectInjectingModifier(object: object))
    }
}
