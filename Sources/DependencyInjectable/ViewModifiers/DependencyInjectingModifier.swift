//
//  DependencyInjectingModifier.swift
//
//  Created by James Sedlacek on 3/6/24.
//

import SwiftUI

/// A view modifier that injects dependencies into a view.
///
/// `DependencyInjectingModifier` is designed to work with objects that conform to
/// both `DependencyInjectable` and `AnyObservable`. It provides a way to inject
/// these objects into the view hierarchy, enabling the objects to configure themselves
/// with dependencies from the environment. This facilitates the use of dependency injection
/// in SwiftUI views, promoting a decoupled and testable design.
///
/// Usage:
/// ```
/// struct ContentView: View {
///     @State var viewModel: ViewModel = .init() // Conforms to DependencyInjectable & AnyObservable
///
///     var body: some View {
///         Text("Hello, SwiftUI!")
///             .modifier(DependencyInjectingModifier(object: viewModel))
///     }
/// }
/// ```
/// In this example, `DependencyInjectingModifier` is used to inject `viewModel` into the
/// `Text` view. The `viewModel` can then access its required dependencies from the environment,
/// allowing for a clean separation of concerns and facilitating easier unit testing.
struct DependencyInjectingModifier<T: DependencyInjectable & AnyObservable>: ViewModifier {
    /// The environment's dependency values.
    @Environment(\.dependencies) private var dependencies

    /// The object to be injected into the view.
    private let object: T

    /// Initializes the modifier with an object to inject.
    ///
    /// - Parameter object: The object to inject into the view, which conforms to both
    ///   `DependencyInjectable` and `AnyObservable`.
    init(object: T) {
        self.object = object
    }

    /// The body of the `ViewModifier`, responsible for injecting the object into the view.
    ///
    /// - Parameter content: The content of the view into which the object is being injected.
    /// - Returns: A modified view with the object injected.
    func body(content: Content) -> some View {
        inject(content)
            .environment(object)
    }

    /// A helper method that injects dependencies into the object and returns the content.
    ///
    /// - Parameter content: The original content of the view.
    /// - Returns: The content, allowing for further modification if necessary.
    private func inject<C: View>(_ content: C) -> some View {
        object.onInject(dependencies: dependencies)
        return content
    }
}
