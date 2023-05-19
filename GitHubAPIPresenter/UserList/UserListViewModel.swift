//
//  UserListViewModel.swift
//  GitHubAPIPresenter
//
//  Created by Johnatas Rodrigues on 17/05/23.
//

import Foundation
import Combine

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var isErrored: Bool = false
    @Published var userError: String = ""
    
    @Published var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                self.isLoading = false
                users = fetchedUsers
            } else {
                isLoading = true
                
                let filteredUsers = fetchedUsers.filter {
                    ($0.login ?? "").lowercased().contains(searchText.lowercased())
                }

                DispatchQueue.main.async {
                    self.users = filteredUsers
                    self.isLoading = false
                }
            }
        }
    }
    
    var fetchedUsers: [User] = []
    
    private let userService: UserServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    func fetchUsers() {
        isLoading = true
        userService.getUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.isLoading = false
                self?.users = users
                self?.fetchedUsers = users
            case .failure(let error):
                self?.isLoading = false
                self?.isErrored = true
                self?.userError = error.localizedDescription
            }
        }
    }

}
