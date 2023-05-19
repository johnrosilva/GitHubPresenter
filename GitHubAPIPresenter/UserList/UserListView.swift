//
//  UserListView.swift
//  GitHubAPIPresenter
//
//  Created by Johnatas Rodrigues on 17/05/23.
//

import Foundation
import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: UserListViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List(viewModel.users) { user in
                    NavigationLink(destination: UserDetailView(
                        viewModel: UserDetailViewModel(user: user))) {
                        UserRow(user: user)
                    }
                }
                .navigationBarTitle("Users")
            }
        }
        .searchable(text: $viewModel.searchText)
        .onAppear {
            viewModel.fetchUsers()
        }
        .alert(isPresented: $viewModel.isErrored) {
            Alert(title: Text("Error!!"),
                  message: Text(viewModel.userError),
                  dismissButton: .default(Text("Ok")))
        }
    }
}

