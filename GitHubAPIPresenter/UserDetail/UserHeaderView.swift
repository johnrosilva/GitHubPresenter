//
//  UserHeaderView.swift
//  GitHubAPIPresenter
//
//  Created by Johnatas Rodrigues on 18/05/23.
//

import SwiftUI

struct UserHeaderView: View {
    let user: User
    
    var body: some View {
        VStack {
            URLImage(url: user.avatarURL)
                .frame(width: 50, height: 50)
                .cornerRadius(50)
                .padding(.top)
            Text(user.login ?? "")
                .font(.title)
            Text("Followers: \(user.followers ?? 0)")
                .font(.subheadline)
            Text("Public Repositories: \(user.publicRepos ?? 0)")
                .font(.subheadline)
        }
    }
}
