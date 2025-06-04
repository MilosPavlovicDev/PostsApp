//
//  ViewModel.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 3. 6. 2025..
//

import Foundation
import SwiftUI

@MainActor
final class ViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = true
    @Published var error: String?

    func loadPosts() async {
        
        isLoading = true
        error = nil
        
        do {
            posts = try await APIService.shared.fetchPosts()
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
