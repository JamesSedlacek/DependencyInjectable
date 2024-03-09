// MARK: Example App

/// Demonstrates dynamic modification of dependencies in a SwiftUI application.
///
/// This `App` struct acts as the entry point, illustrating not just the injection of dependencies
/// but also their dynamic modification within the SwiftUI environment. This adaptability showcases
/// how the library supports changes to the dependency injection environment, catering to different
/// application states or testing needs.
///
/// It highlights the library's capacity to dynamically add, update, or remove services like `ExampleService`.
/// This feature is crucial for applications requiring a flexible architecture to adjust dependencies based
/// on runtime conditions, user preferences, or other factors.
///
/// Usage:
/// - Here, the `ContentView` setup is enhanced by demonstrating how the environment can be adjusted to
///   replace the `exampleService` dependency dynamically. This is especially useful for testing or when
///   application configuration changes necessitate a different set of services.
///
@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Showcases dynamic modification of the dependency injection environment.
        // This example modifies the `exampleService` dependency, highlighting the library's flexibility.
        .environment(
            \.dependencies.exampleService,
             ExampleService("Testing")
        )
    }
}
