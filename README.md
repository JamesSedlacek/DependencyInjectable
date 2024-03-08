# Dependency Injectable

This library offers a lightweight and powerful solution for integrating dependency injection into SwiftUI applications.
Leveraging the latest native APIs, it facilitates a modular architecture by allowing dependencies to be injected directly into SwiftUI views and view models.
This approach simplifies testing and development by decoupling your app's components.

## Table of Contents
1. [Features](#features)
2. [Requirements](#requirements)
3. [Installation](#installation)
4. [Setup](#setup)
5. [Usage](#usage)
6. [Author](#author)

## Features

- **Type-Safe Dependencies**: Utilize Swift's type system to ensure that your dependencies are correctly resolved at compile time.
- **SwiftUI Integration**: Designed with SwiftUI in mind, it seamlessly integrates into the SwiftUI lifecycle and environment.
- **Observability**: Supports the injection of observable objects, allowing your views to react dynamically to changes in your dependencies.
- **Ease of Use**: Simplify the management of your app's dependencies with minimal boilerplate code.

## Requirements

| Platform | Minimum Version |
|----------|-----------------|
| iOS      | 17.0            |
| macOS    | 14.0            |
| tvOS     | 17.0            |
| watchOS  | 10.0            |

## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It integrates with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

#### Xcode

To integrate DependencyInjectable into your Xcode project using Xcode 15 or later, follow these steps:

1. Open your project in Xcode.
2. Select `File` > `Swift Packages` > `Add Package Dependency...`
3. Enter the package repository URL: 
```
https://github.com/JamesSedlacek/DependencyInjectable.git
```
4. Choose the version rule that makes sense for your project.
5. Select `Add Package`.

#### Package.swift

If you are developing a Swift package or have a project that already uses `Package.swift`, you can add YourPackageName as a dependency:

```swift
// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "DependencyInjectable",
    dependencies: [
        .package(url: "https://github.com/JamesSedlacek/DependencyInjectable.git", branch: "main")
    ],
    targets: [
        .target(
            name: "YourTargetName",
            dependencies: ["DependencyInjectable"])
    ]
)
```

## Setup

To set up dependency injection for your project, follow these steps:

1. Define your services or dependencies conforming to the `DependencyInjectable` protocol.
2. Create dependency keys conforming to the `DependencyKey` protocol for each dependency.
3. Extend `DependencyValues` to include your dependencies for easy access throughout your application.

## Usage

### Defining a Service

Define a protocol for your service and an implementation:

```swift
protocol ExampleServiceable {
    var someProperty: String { get }
}

struct ExampleService: ExampleServiceable {
    let someProperty = "Wow it works!"
}
```

### Creating a Dependency Key

Define a key for your service in the dependency container:

```swift
struct ExampleServiceKey: DependencyKey {
    static var defaultValue: ExampleServiceable = ExampleService()
}
```

### Extending DependencyValues

Extend `DependencyValues` for dot notation access to your service:

```swift
extension DependencyValues {
    var exampleService: ExampleServiceable {
        get { self[ExampleServiceKey.self] }
        set { self[ExampleServiceKey.self] = newValue }
    }
}
```

### Updating or removing dependencies from the environment
```swift
@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(
            \.dependencies.exampleService,
             ExampleService("Testing")
        )
    }
}
```

### Injecting a ViewModel into the environment, with dependencies
```swift
@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .inject(ContentViewModel())
        }
    }
}
```

### Injecting dependencies into a ViewModel

Create a view model that injects your service using the `@Observable` macro and the `DependencyInjectable` protocol:

```swift
@Observable
final class ContentViewModel: DependencyInjectable {
    var service: ExampleServiceable?

    var someProperty: String {
        service?.someProperty ?? "default value"
    }

    func onInject(dependencies: DependencyValues) {
        service = dependencies.exampleService
    }
}
```

### Using Injected ViewModel in a SwiftUI View

```swift
struct ContentView: View {
    @Environment(ContentViewModel.self)
    private var viewModel

    var body: some View {
        Text(viewModel.someProperty)
    }
}
```

### Using a dependency from the environment in a SwiftUI View

```swift
struct ContentView: View {
    @Environment(\.dependencies.exampleService)
    private var service

    var body: some View {
        Text(service.someProperty)
    }
}
```

## Author

James Sedlacek, find me on [X/Twitter](https://twitter.com/jsedlacekjr) or [LinkedIn](https://www.linkedin.com/in/jamessedlacekjr/)
