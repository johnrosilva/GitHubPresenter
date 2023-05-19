//
//  URLImage.swift
//  GitHubAPIPresenter
//
//  Created by Johnatas Rodrigues on 18/05/23.
//

import SwiftUI

struct URLImage: View {
    let url: String?
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? ""),
                   content: { $0.resizable() },
                   placeholder: { ProgressView() })
            .frame(width: 50, height: 50)
            .cornerRadius(25)
    }
    
}
