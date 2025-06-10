import Foundation

protocol DataServiceProtocol {
    func fetchGreeting() async throws -> String
}

class NetworkService: DataServiceProtocol {
    func fetchGreeting() async throws -> String {
        // This simulates a real network call that takes 2 seconds.
        try await Task.sleep(for: .seconds(2))
        
        // In a real app, you might get a random error.
        if Bool.random() {
            return "Hello from the Network!"
        } else {
            throw URLError(.badServerResponse)
        }
    }
}
