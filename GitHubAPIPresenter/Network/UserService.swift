//
//  UserListProtocol.swift
//  GitHubAPIPresenter
//
//  Created by Johnatas Rodrigues on 17/05/23.
//

import Combine
import Foundation

protocol UserServiceProtocol {
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void)
    func getUser(login: String, completion: @escaping (Result<User, Error>) -> Void)
    func getRepositories(login: String, completion: @escaping (Result<[Repository], Error>) -> Void)
}

class UserService: GitHubPresenterService, UserServiceProtocol {
    
    private var cancellables = Set<AnyCancellable>()
    private let uiTesting = ProcessInfo.processInfo.arguments.contains("Testing")
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        if uiTesting {
            completion(.success(mockUsers))
        } else {
            guard let url = UserEndpoint.users.url else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
                completion(.failure(error))
                return
            }
            
            super.fetchData(url: url, decodingType: [User].self) { result in
                completion(result)
            }
        }
    }
    
    func getUser(login: String, completion: @escaping (Result<User, Error>) -> Void) {
        if uiTesting {
            completion(.success(mockUser))
        } else {
            guard let url = UserEndpoint.user(login: login).url else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
                completion(.failure(error))
                return
            }
            
            super.fetchData(url: url, decodingType: User.self) { result in
                completion(result)
            }
        }
    }

    func getRepositories(login: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        if uiTesting {
            completion(.success(mockRepositories))
        } else {
            guard let url = UserEndpoint.repositories(login: login).url else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
                completion(.failure(error))
                return
            }
            
            super.fetchData(url: url, decodingType: [Repository].self) { result in
                completion(result)
            }
        }
    }
}


// Extension for Mocked Data
extension UserService {
    var mockUsers: [User] {
        if uiTesting {
            let bundle = Bundle(for: type(of: self))
            guard let url = bundle.url(forResource: "users_mock", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let users = try? JSONDecoder().decode([User].self, from: data) else {
                return []
            }
            return users
        } else {
            return []
        }
    }
    
    var mockUser: User {
        if uiTesting {
            let bundle = Bundle(for: type(of: self))
            guard let url = bundle.url(forResource: "user_mock", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let user = try? JSONDecoder().decode(User.self, from: data) else {
                return User()
            }
            return user
        } else {
            return User()
        }
    }
    
    var mockRepositories: [Repository] {
        if uiTesting {
            let bundle = Bundle(for: type(of: self))
            guard let url = bundle.url(forResource: "repos_mock", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let repositories = try? JSONDecoder().decode([Repository].self, from: data) else {
                return []
            }
            return repositories
        } else {
            return []
        }
    }
}
