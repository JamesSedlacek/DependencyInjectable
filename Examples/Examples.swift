//
//  Examples.swift
//  Demonstrates a simple SwiftUI dependency injection system.
//
// This file showcases a dependency injection system within a SwiftUI application, aimed at enhancing modularity and testability.
// It defines an `ExampleServiceable` protocol and a concrete `ExampleService` implementation to be used across the application.
// Utilizing a `DependencyKey` and extending `DependencyValues`, it enables type-safe storage and retrieval of services within the dependency injection container.
//
// The `ExampleApp` struct illustrates how to inject dependencies into the SwiftUI environment,
// allowing for flexible configuration and testing. The `ContentView` demonstrates accessing these
// dependencies both directly and via an injected view model, `ContentViewModel`, which
// adopts `DependencyInjectable` for dynamic UI updates through SwiftUI's `@Observable`.
// This approach fosters a clean separation of concerns and showcases the practical application of dependency injection in a SwiftUI app.
//


import SwiftUI

// MARK: - Example Service Definition

/// Protocol defining the interface for an example service.
///
/// This protocol specifies a property `someProperty` that implementations must provide.
/// It represents a simple service that could be used for demonstration purposes in
/// the dependency injection system.
protocol ExampleServiceable {
    var someProperty: String { get }
}

/// A concrete implementation of `ExampleServiceable`.
///
/// This struct provides an implementation of the `ExampleServiceable` protocol,
/// showcasing a basic service that could be injected into views or other components
/// within a SwiftUI application.
struct ExampleService: ExampleServiceable {
    let someProperty = "Wow it works!"
}

// MARK: - Dependency Key for Example Service

/// A dependency key for accessing the `ExampleService` within the dependency injection system.
///
/// This key allows the `ExampleService` (or any `ExampleServiceable` implementation) to be
/// stored and retrieved from the dependency injection container (`DependencyValues`). It includes
/// a default value to ensure that there is always a valid instance available.
struct ExampleServiceKey: DependencyKey {
    static var defaultValue: ExampleServiceable = ExampleService()
}

// MARK: - DependencyValues Extension for Example Service

/// Extension to provide dot notation access to `ExampleServiceable` within `DependencyValues`.
///
/// This extension adds a convenient property to `DependencyValues` for accessing an
/// `ExampleServiceable` instance. It utilizes the `ExampleServiceKey` for type-safe storage
/// and retrieval, simplifying the usage of the example service within the dependency injection
/// system.
extension DependencyValues {
    var exampleService: ExampleServiceable {
        get {
            self[ExampleServiceKey.self]
        }
        set {
            self[ExampleServiceKey.self] = newValue
        }
    }
}

// MARK: Example App

/// The root structure of the SwiftUI application that demonstrates dependency injection.
///
/// This `App` struct defines the entry point of the application and sets up the primary view
/// within a `WindowGroup`. It showcases how to inject a view model, complete with its dependencies,
/// into the SwiftUI environment. This approach facilitates the use of dependency injection
/// to provide a modular and testable architecture.
///
/// In addition, it demonstrates the dynamic modification of the dependency injection environment.
/// This allows for the addition, update, or removal of services, such as `ExampleService`, making
/// it versatile and adaptable to different requirements or testing scenarios.

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()

                // Demonstrates injecting a viewModel into the environment, including its dependencies.
                .inject(ContentViewModel())
        }

        // Demonstrates how to modify the dependency injection environment to add, update,
        // or remove dependencies, specifically the example service in this case.
        .environment(
            \.dependencies.exampleService,
             ExampleService("Testing")
        )
    }
}

// MARK: ContentView

/// A SwiftUI view demonstrating the access and usage of dependencies injected into the environment.
///
/// `ContentView` utilizes the dependency injection system to access `ExampleServiceable` directly
/// from the environment and through a view model. This illustrates two common patterns of dependency
/// injection in SwiftUI: direct service access and view model-based access. The direct access
/// approach is straightforward and suitable for simple use cases, whereas the view model-based
/// access encapsulates the service usage within a separate logic layer, promoting a clean separation
/// of concerns and enhanced testability.

struct ContentView: View {

    // Accesses dependencies directly from the environment, enabling direct use within the view.
    @Environment(\.dependencies.exampleService) private var service

    // Retrieves the viewModel, which includes injected dependencies, from the Environment for use.
    @Environment(ContentViewModel.self) private var viewModel

    init() {}

    var body: some View {

        // Demonstrates direct usage of the service from the environment.
        Text(service.someProperty)

        // Demonstrates usage of the service through a viewModel, showcasing dependency injection.
        Text(viewModel.someProperty)
    }
}

// MARK: - Observable Content ViewModel

/// A view model class leveraging SwiftUI's `@Observable` to enable dynamic UI updates based on changes to its properties.
/// It incorporates dependency injection to utilize services within the application, demonstrating a scalable and modular approach.
///
/// This class adopts the `DependencyInjectable` protocol, indicating it can receive dependencies from the dependency injection system.
/// It primarily uses an instance of `ExampleServiceable` to showcase how services can be injected and utilized within the application logic,
/// facilitating a separation of concerns and enhancing testability. The `onInject` method configures the view model with necessary dependencies
/// from `DependencyValues`, showcasing the integration with the dependency injection framework.
@Observable
final class ContentViewModel: DependencyInjectable {
    var service: ExampleServiceable?

    // Provides access to `someProperty` from the injected service, with a fallback default value
    var someProperty: String {
        service?.someProperty ?? "default value"
    }

    init() {}

    // Injects dependencies from `DependencyValues`, specifically an `ExampleServiceable` instance.
    func onInject(dependencies: DependencyValues) {
        service = dependencies.exampleService
    }
}
