//
//  ObservableInjectingModifier.swift
//
//  Created by James Sedlacek on 3/6/24.
//

import SwiftUI

/// A view modifier that enables dependency injection for views within the SwiftUI framework.
/// This modifier is designed to inject dependencies into views that conform to both `DependencyInjectable`
/// and `AnyObservable`, facilitating a decoupled and testable design by allowing these objects
/// to configure themselves with dependencies from the environment.
///
/// Usage Example:
/// ```
/// struct ContentView: View {
///     @State var viewModel: ViewModel = .init() // ViewModel conforms to DependencyInjectable & AnyObservable
///
///     var body: some View {
///         Text("Hello, SwiftUI!")
///             .modifier(ObservableInjectingModifier(object: viewModel))
///     }
/// }
/// ```
/// In this example, `ObservableInjectingModifier` is used to inject the `viewModel` into the
/// `Text` view, allowing the `viewModel` to access its required dependencies from the environment.
@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
struct ObservableInjectingModifier<T: DependencyInjectable & AnyObservable>: ViewModifier {
    /// The environment's dependency values.
    @Environment(\.dependencies) private var dependencies

    /// The object to be injected into the view. This object must conform to both
    /// `DependencyInjectable` and `AnyObservable`.
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
    /// - Returns: A modified view with the object injected, enabling it to access dependencies from the environment.
    func body(content: Content) -> some View {
        inject(content)
            .environment(object)
    }

    /// A helper method that injects dependencies into the object and returns the content.
    /// This method is called within the `body` to ensure that the object has its dependencies
    /// injected before the content is rendered.
    ///
    /// - Parameter content: The original content of the view.
    /// - Returns: The content, allowing for further modification if necessary.
    private func inject<C: View>(_ content: C) -> some View {
        object.onInject(dependencies: dependencies)
        return content
    }
}
