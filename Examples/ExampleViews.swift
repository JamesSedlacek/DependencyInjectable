import SwiftUI

// MARK: ContentView

/// Demonstrates different patterns of accessing and utilizing injected dependencies within SwiftUI views.
///
/// This file showcases three distinct approaches to dependency injection in SwiftUI:
/// 1. Direct service access from the environment.
/// 2. ViewModel-based access using `@Environment`.
/// 3. ViewModel-based access using `@EnvironmentObject`.
///
/// Each approach serves different use cases, from straightforward service usage to encapsulating
/// logic within a ViewModel, promoting clean architecture and easier testing.

// Direct service access from the environment, suitable for simple scenarios.
struct ContentViewDirectAccess: View {
    @Environment(\.dependencies.exampleService) private var service

    var body: some View {
        Text(service.someProperty) // Directly displays a property from the injected service.
    }
}

// ViewModel-based access using `@Environment`, demonstrating dependency injection through ViewModel.
struct ContentViewWithViewModel: View {
    @Environment(ContentViewModel.self) private var viewModel

    var body: some View {
        Text(viewModel.someProperty) // Uses ViewModel to access and display the service property.
    }
}

// ViewModel-based access using `@EnvironmentObject`, for complex scenarios with ObservableObject.
struct ContentViewWithViewModelObservable: View {
    @EnvironmentObject private var viewModel: ContentViewModelObservable

    var body: some View {
        Text(viewModel.someProperty) // Showcases ViewModel usage, accessing the service property.
    }
}

/// Each `ContentView` variant exemplifies a different method of dependency access, highlighting
/// the library's flexibility in integrating with SwiftUI's architecture. Choose the approach that
/// best fits your app's needs, whether it's for simplicity, encapsulation, or observing changes.
