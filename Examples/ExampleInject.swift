import Foundation

import Foundation

// MARK: Example App

/// The root structure of the SwiftUI application, showcasing the simplicity and power of dependency injection.
///
/// This `App` struct is the entry point of the application, setting up the primary view in a `WindowGroup`.
/// It exemplifies the library's core feature: injecting a ViewModel, along with its dependencies, directly
/// into the SwiftUI environment. This technique supports a modular and easily testable architecture by
/// streamlining dependency management.
///
/// Additionally, this example highlights the dynamic nature of the dependency injection environment
/// provided by the library. Developers can effortlessly add, update, or remove services, like `ExampleService`,
/// adapting to various needs or testing contexts with minimal effort.
///
/// Usage:
/// - Demonstrates the injection of `ContentViewModel` into `ContentView`, leveraging the `.inject()` method
///   to seamlessly integrate ViewModel dependencies into the SwiftUI view hierarchy.
///
@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                // Showcases how to inject a ViewModel into the environment, encapsulating its dependencies.
                .inject(ContentViewModel())
        }
    }
}
