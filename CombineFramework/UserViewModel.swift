//
//  UserViewModel.swift
//  CombineFramework
//
//  Created by Amit Sharma on 6/12/25.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func fetchUsers() {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { users in
                self.users = users
            })
            .store(in: &cancellables)
    }
}
