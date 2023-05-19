//
//  UserDetailViewModel.swift
//  GitHubAPIPresenter
//
//  Created by Johnatas Rodrigues on 17/05/23.
//

import Foundation
import Combine

class UserDetailViewModel: ObservableObject {
    private let userService: UserServiceProtocol
    
    @Published var user: User
    @Published var repositories: [Repository] = []
    @Published var isLoading: Bool = false
    @Published var isErrored: Bool = false
    @Published var userError: String = ""
    
    init(userService: UserServiceProtocol = UserService(),
         user: User,
         repositories: [Repository] = []) {
        self.userService = userService
        self.user = user
        self.repositories = repositories
    }
    
    func fetchData() {
        guard let login = user.login else {
            return
        }
        fetchUser(login: login)
        fetchRepositories(login: login)
    }
    
    func fetchUser(login: String) {
        isLoading = true
        userService.getUser(login: login) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.isLoading = false
                self?.isErrored = true
                self?.userError = error.localizedDescription
            }
        }
    }
        
    func fetchRepositories(login: String) {
        isLoading = true
        userService.getRepositories(login: login) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories
                self?.isLoading = false
            case .failure(let error):
                self?.isLoading = false
                self?.isErrored = true
                self?.userError = error.localizedDescription
            }
        }
    }
}
