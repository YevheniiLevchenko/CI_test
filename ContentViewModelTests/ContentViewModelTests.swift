import XCTest
@testable import CI_test

// 1. Create a MOCK version of service.
class MockDataService: DataServiceProtocol {
    var greetingToReturn: String? // Control what data it returns
    
    func fetchGreeting() async throws -> String {
        if let greeting = greetingToReturn {
            return greeting
        } else {
            // If no data is provided, we simulate an error.
            throw URLError(.notConnectedToInternet)
        }
    }
}

// 2. Write the tests for the ContentViewModel.
@MainActor
final class ContentViewModelTests: XCTestCase {

    var viewModel: ContentViewModel!
    var mockService: MockDataService!

    override func setUp() {
        super.setUp()
        mockService = MockDataService()
        viewModel = ContentViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    // Test the SUCCESS case
    func test_loadContent_whenFetchSucceeds_shouldUpdateStateToLoaded() async {
        // Given: We tell the mock service to return a specific greeting.
        let expectedMessage = "Hello, Tester!"
        mockService.greetingToReturn = expectedMessage
        
        // When: We call the function we want to test.
        await viewModel.loadContent()
        
        // Then: We assert that the ViewModel's state is what we expect.
        XCTAssertEqual(viewModel.state, .loaded(message: expectedMessage), "The state should be loaded with the correct message.")
    }

    // Test the FAILURE case
    func test_loadContent_whenFetchFails_shouldUpdateStateToError() async {
        // Given: We tell the mock service to fail by not providing any data.
        mockService.greetingToReturn = nil
        
        // When: We call the function.
        await viewModel.loadContent()
        
        // Then: We assert that the state is an error state.
        XCTAssertEqual(viewModel.state, .error(description: "Failed to load data."), "The state should be error when the service fails.")
    }
}
