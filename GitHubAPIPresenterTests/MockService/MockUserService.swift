//
//  MockUserService.swift
//  GitHubAPIPresenterTests
//
//  Created by Johnatas Rodrigues on 18/05/23.
//

import Foundation
@testable import GitHubAPIPresenter

class MockUserService: UserServiceProtocol {
    var getUsersResult: Result<[User], Error> = .failure(MockError.mockFailure)
    var getUserResult: Result<User, Error> = .failure(MockError.mockFailure)
    var getRepositoriesResult: Result<[Repository], Error> = .failure(MockError.mockFailure)
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        completion(getUsersResult)
    }
    
    func getUser(login: String, completion: @escaping (Result<User, Error>) -> Void) {
        completion(getUserResult)
    }
    
    func getRepositories(login: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        completion(getRepositoriesResult)
    }
}

enum MockError: Error {
    case mockFailure
}

