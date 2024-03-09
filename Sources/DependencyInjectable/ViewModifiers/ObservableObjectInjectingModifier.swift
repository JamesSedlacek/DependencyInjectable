//
//  ObservableObjectInjectingModifier.swift
//
//
//  Created by James Sedlacek on 3/9/24.
//

import SwiftUI

struct ObservableObjectInjectingModifier<T: DependencyInjectable & AnyObservableObject>: ViewModifier {
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
            .environmentObject(object)
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
