//
//  ContentViewModel.swift
//  CI_test
//
//  Created by Yevhenii Levchenko on 10.06.2025.
//

import Foundation
import Combine

// 3. Define the possible states for the view.
enum ViewState: Equatable {
    case idle
    case loading
    case loaded(message: String)
    case error(description: String)
}

class ContentViewModel: ObservableObject {
    @Published var state: ViewState = .idle
    private let service: DataServiceProtocol

    init(service: DataServiceProtocol = NetworkService()) {
        self.service = service
    }

    func loadContent() async {
        state = .loading
        do {
            let message = try await service.fetchGreeting()
            state = .loaded(message: message)
        } catch {
            state = .error(description: "Failed to load data.")
        }
    }
}
