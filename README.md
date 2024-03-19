# Dependency Injectable
[![Platforms](https://img.shields.io/badge/platforms-_iOS_|_macOS_|_watchOS_|_tvOS-lightgrey.svg?style=flat)](https://developer.apple.com/resources/)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://mit-license.org)

This library offers a lightweight (<50 executable lines of code) and powerful solution for integrating dependency injection into SwiftUI applications.
Leveraging the latest native APIs, it facilitates a modular architecture by allowing dependencies to be injected directly into SwiftUI views and view models.
This approach simplifies testing and development by decoupling your app's components.

## Table of Contents
1. [Motivation](#motivation)
2. [Features](#features)
3. [Requirements](#requirements)
4. [Installation](#installation)
5. [Setup](#setup)
6. [Usage](#usage)
7. [Examples](https://github.com/JamesSedlacek/DependencyInjectable/blob/main/Examples)
8. [Author](#author)

## Motivation

Developing SwiftUI applications with a clean and scalable architecture is a challenge many developers, including myself, face. A particular hurdle is managing and accessing environment variables efficiently within ObservableObject or ViewModels. To address this, I created a library designed to streamline this process, enhancing both the architecture and the developer experience in SwiftUI applications.

### Simplifying Environment Variable Access
My primary goal was to make accessing environment variables within ObservableObject or ViewModel instances as straightforward as possible. This library reduces the need for verbose and repetitive code, allowing for a cleaner, more readable approach to sharing data across your UI components.
<br>
### Encouraging Modular Architecture
By easing the injection of environment variables, this library promotes a decoupled, modular design, making components more reusable and testable. This not only aids in maintaining a solid architectural foundation but also aligns with best practices for software development, resulting in more reliable applications.
<br>
### Designed for SwiftUI and Developers
As a tool built specifically for SwiftUI, this library leverages the framework's features to the fullest, aiming to improve the overall development experience. It simplifies the complexities associated with data flow and dependency management, allowing you to focus more on creating engaging user experiences.
<br>
In summary, this library is my contribution to solving a common problem in SwiftUI development. It's designed to make your workflow more efficient and your codebase more manageable, empowering you to build better apps with less effort. 

## Features

- **Type-Safe Dependencies**: Utilize Swift's type system to ensure that your dependencies are correctly resolved at compile time.
- **SwiftUI Integration**: Designed with SwiftUI in mind, it seamlessly integrates into the SwiftUI lifecycle and environment.
- **Observability**: Supports the injection of observable objects, allowing your views to react dynamically to changes in your dependencies.
- **Ease of Use**: Simplify the management of your app's dependencies with minimal boilerplate code.

## Requirements

| Platform | Minimum Version |
|----------|-----------------|
| iOS      | 13.0            |
| macOS    | 10.15           |
| tvOS     | 13.0            |
| watchOS  | 6.0             |

## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It integrates with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

#### Xcode

To integrate `DependencyInjectable` into your Xcode project using Xcode 15 or later, follow these steps:

1. Open your project in Xcode.
2. Select `File` > `Swift Packages` > `Add Package Dependency...`
3. Enter the package repository URL: 
```
https://github.com/JamesSedlacek/DependencyInjectable.git
```
4. Choose the version rule that makes sense for your project.
5. Select `Add Package`.

#### Package.swift

If you are developing a Swift package or have a project that already uses `Package.swift`, you can add `DependencyInjectable` as a dependency:

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

1. Define a protocol and implementation for your dependencies.
2. For each of your dependencies, create a dependency key that conforms to the `DependencyKey` protocol.
3. Extend `DependencyValues` to include your dependencies for easy key path access throughout your application.

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

Create a view model that injects your dependencies using the `DependencyInjectable` protocol: <br>
> [!NOTE]
> `onInject(dependencies:)` gets called automatically by the `.inject(:)` view modifier.

```swift
@Observable
final class ContentViewModel: DependencyInjectable {
    var service: (any ExampleServiceable)?

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
