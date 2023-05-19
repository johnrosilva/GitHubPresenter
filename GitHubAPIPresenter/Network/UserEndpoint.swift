//
//  APIEndpoint.swift
//  GitHubAPIPresenter
//
//  Created by Johnatas Rodrigues on 18/05/23.
//

import Foundation

enum UserEndpoint {
    case users
    case user(login: String)
    case repositories(login: String)
    
    var url: URL? {
        let baseURL = "https://api.github.com"
        
        switch self {
        case .users:
            let userPath = "/users"
            return URL(string: baseURL + userPath)
        case .user(let login):
            let userPath = "/users/\(login)"
            return URL(string: baseURL + userPath)
            
        case .repositories(let login):
            let repositoriesPath = "/users/\(login)/repos"
            return URL(string: baseURL + repositoriesPath)
        }
    }
}

