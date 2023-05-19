//
//  UserDetailView.swift
//  GitHubAPIPresenter
//
//  Created by Johnatas Rodrigues on 17/05/23.
//

import SwiftUI

struct UserDetailView: View {
    @ObservedObject var viewModel: UserDetailViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                VStack {
                    UserHeaderView(user: viewModel.user)
                    if viewModel.repositories.isEmpty {
                        emptyView
                    } else {
                        List(viewModel.repositories, id: \.fullName) { repository in
                            RepositoryRow(repository: repository)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(viewModel.user.name ?? "")
        .onAppear {
            viewModel.fetchData()
        }
        .alert(isPresented: $viewModel.isErrored) {
            Alert(title: Text("Error!!"),
                  message: Text(viewModel.userError),
                  dismissButton: .default(Text("Ok")))
        }
    }
    
    var emptyView: some View {
        VStack {
            Spacer()
            Image(systemName: "xmark.bin.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
            
            Text("No Repositories")
                .font(.title)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
        .background {
            Color(.systemGroupedBackground)
        }
        
    }
}
