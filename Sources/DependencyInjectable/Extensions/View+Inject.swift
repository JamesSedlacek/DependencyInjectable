//
//  View+Inject.swift
//
//  Created by James Sedlacek on 3/6/24.
//

import SwiftUI

/// An extension for `View` to enable dependency injection of observables.
///
/// This extension provides a method to inject dependencies into SwiftUI views.
/// The dependencies must conform to both `DependencyInjectable` and `AnyObservable`,
/// allowing the injection of observable objects that can participate in SwiftUI's
/// data flow system. This method enhances view composition by enabling cleaner
/// and more modular dependency management.
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
/// In this example, `viewModel` is injected into `ContentView`, allowing `ContentView`
/// to observe changes to `viewModel` and re-render as necessary.
extension View {
    /// Injects a dependency into the view.
    ///
    /// - Parameter object: The dependency to inject, which conforms to both
    ///   `DependencyInjectable` and `AnyObservable`. This allows the injected object
    ///   to be observed for changes, integrating with SwiftUI's reactive update mechanism.
    /// - Returns: A view that has the dependency injected, enabling it to participate
    ///   in the data flow of a SwiftUI application.
    public func inject<T: DependencyInjectable & AnyObservable>(_ object: T) -> some View {
        modifier(DependencyInjectingModifier(object: object))
    }
}
