//
//  UserRow.swift
//  GitHubAPIPresenter
//
//  Created by Johnatas Rodrigues on 18/05/23.
//

import SwiftUI

struct UserRow: View {
    let user: User
    
    var body: some View {
        HStack {
            URLImage(url: user.avatarURL)
            Text(user.login ?? "Anonymus")
        }
    }
}
