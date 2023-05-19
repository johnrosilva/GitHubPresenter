//
//  GitHubAPIPresenterApp.swift
//  GitHubAPIPresenter
//
//  Created by Johnatas Rodrigues on 17/05/23.
//

import SwiftUI

@main
struct GitHubAPIPresenterApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView(viewModel: UserListViewModel(userService: UserService()))
        }
    }
}
