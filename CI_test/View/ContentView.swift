//
//  ContentView.swift
//  CI_test
//
//  Created by Yevhenii Levchenko on 10.06.2025.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Hello, world!")
        }
        .padding()
        .task {
            await viewModel.loadContent()
        }
    }
}

#Preview {
    ContentView()
}
