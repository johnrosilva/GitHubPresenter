//
//  RepositoryRow.swift
//  GitHubAPIPresenter
//
//  Created by Johnatas Rodrigues on 18/05/23.
//

import SwiftUI

struct RepositoryRow: View {
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(repository.name ?? "")
                .font(.headline)
            
            Text(repository.description ?? "")
                .font(.subheadline)
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("\(repository.stargazersCount ?? 0)")
                    .font(.subheadline)
            }
        }
        .padding()
    }
}
