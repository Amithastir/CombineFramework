//
//  ContentView.swift
//  CombineFramework
//
//  Created by Amit Sharma on 6/12/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            contentView
                .navigationTitle("Users")
                .onAppear {
                    viewModel.fetchUsers()
                }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else if let error = viewModel.errorMessage {
            Text("Error: \(error)")
                .foregroundStyle(.secondary)
        } else {
            List(viewModel.users) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
