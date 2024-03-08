import XCTest
@testable import DependencyInjectable

final class DependencyValuesTests: XCTestCase {
    func testDependencyRegistrationAndRetrieval() {
        // Setup
        var dependencies = DependencyValues()
        let mockService = MockService()
        dependencies[MockServiceKey.self] = mockService

        // Test retrieval
        let retrievedService: MockServiceable = dependencies[MockServiceKey.self]

        // Verify
        XCTAssertEqual(
            retrievedService.someProperty,
            mockService.someProperty,
            "The retrieved service should match the registered service."
        )
    }


    func testDefaultValueRetrieval() {
        // Setup
        let dependencies = DependencyValues()

        // Test retrieval of a dependency that hasn't been registered
        let service: MockServiceable = dependencies[MockServiceKey.self]

        // Verify
        XCTAssertEqual(
            service.someProperty,
            MockServiceKey.defaultValue.someProperty,
            "Should return the default value for unregistered dependencies."
        )
    }

    func testDependencyReplacement() {
        // Initial registration
        var dependencies = DependencyValues()
        dependencies[MockServiceKey.self] = MockService("Initial")

        // Replace dependency
        let newService = MockService("Replaced")
        dependencies[MockServiceKey.self] = newService

        // Test retrieval
        let retrievedService: MockServiceable = dependencies[MockServiceKey.self]

        // Verify
        XCTAssertEqual(
            retrievedService.someProperty,
            "Replaced",
            "The retrieved service should be the newly replaced service."
        )
    }

    func testDependencyInjectableConformance() {
        // Setup
        var dependencies = DependencyValues()
        dependencies[MockServiceKey.self] = MockService("Injected")
        let viewModel = MockViewModel()

        // Inject dependencies
        viewModel.onInject(dependencies: dependencies)

        // Verify
        XCTAssertEqual(
            viewModel.someProperty,
            "Injected",
            "The view model should have the injected dependency's property."
        )
    }

    func testDependencyValuesDescription() {
        // Setup
        var dependencies = DependencyValues()
        let mockService = MockService()
        dependencies[MockServiceKey.self] = mockService

        // Expected description format
        let expectedDescription = "DependencyValues contains 1 dependencies."

        // Retrieve the actual description
        let actualDescription = dependencies.description

        // Verify
        XCTAssertEqual(
            actualDescription,
            expectedDescription,
            "The description of DependencyValues does not match the expected format or content."
        )
    }
}
