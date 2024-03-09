import Foundation

// MARK: - Observable Content ViewModel

/// Demonstrates dynamic UI updates in SwiftUI using dependency injection within a view model.
///
/// This view model class showcases how to use dependency injection to integrate services,
/// such as `ExampleServiceable`, enabling a scalable and modular application structure.
/// It highlights the adoption of the `DependencyInjectable` protocol, allowing the view model
/// to receive and utilize dependencies seamlessly from the dependency injection system.
///
/// - `@Observable` version is ideal for simpler scenarios, where property observation is required
///   without full `ObservableObject` conformance.
/// - The `ObservableObject` conformance version exemplifies a more standard approach within SwiftUI,
///   suitable for complex use cases involving multiple properties and the need for `@Published` properties.
///
/// Each version demonstrates the `onInject` method's role in configuring the view model with
/// dependencies from `DependencyValues`, emphasizing the ease of integrating services and promoting
/// testability and separation of concerns in application logic.

@Observable
final class ContentViewModel: DependencyInjectable {
    var service: ExampleServiceable?

    // Accesses `someProperty` from the injected service, with a fallback default value.
    var someProperty: String {
        service?.someProperty ?? "default value"
    }

    init() {}

    // Injects dependencies, specifically an `ExampleServiceable` instance.
    func onInject(dependencies: DependencyValues) {
        service = dependencies.exampleService
    }
}

// ObservableObject version for more complex scenarios or when using `@Published` properties.
final class ContentViewModelObservable: DependencyInjectable, ObservableObject {
    var service: ExampleServiceable?

    // Similar access pattern to `someProperty`, showcasing dependency usage.
    var someProperty: String {
        service?.someProperty ?? "default value"
    }

    init() {}

    // Injects dependencies, with focus on `ExampleServiceable`, from `DependencyValues`.
    func onInject(dependencies: DependencyValues) {
        service = dependencies.exampleService
    }
}
