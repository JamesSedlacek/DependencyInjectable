// MARK: - Example Service Definition

/// Protocol for a sample service illustrating the library's dependency injection capabilities.
///
/// This protocol outlines a basic interface with a `someProperty` property, demonstrating how services
/// can be defined and later injected into SwiftUI views or other components. It's designed to exemplify
/// the flexibility and adaptability of the dependency injection system in managing service dependencies.
protocol ExampleServiceable {
    var someProperty: String { get }
}

/// Concrete implementation of `ExampleServiceable`.
///
/// This struct exemplifies a simple service, showcasing the straightforward integration of service
/// implementations into the SwiftUI application through dependency injection. It underscores the library's
/// ability to support clean, modular architecture by facilitating the injection of concrete service
/// instances where needed.
struct ExampleService: ExampleServiceable {
    let someProperty = "Service Operational!"
}

// MARK: - Dependency Key for Example Service

/// Key for accessing `ExampleService` within the dependency injection system.
///
/// Defines a dependency key for `ExampleService` (or any `ExampleServiceable` implementation),
/// allowing for type-safe storage and retrieval from the dependency injection container. The inclusion
/// of a default value guarantees a seamless integration and usage within the SwiftUI application, ensuring
/// that services can be easily accessed and manipulated as part of the dependency injection process.
struct ExampleServiceKey: DependencyKey {
    static var defaultValue: ExampleServiceable = ExampleService()
}

// MARK: - DependencyValues Extension for Example Service

/// Extends `DependencyValues` to include `ExampleServiceable`, enabling dot-notation access.
///
/// This extension augments `DependencyValues` with a property for `ExampleServiceable`, leveraging
/// `ExampleServiceKey` for consistent, type-safe access. It simplifies the incorporation and usage of
/// services within the app, demonstrating the library's commitment to enhancing the developer experience
/// by streamlining dependency management in SwiftUI applications.
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
