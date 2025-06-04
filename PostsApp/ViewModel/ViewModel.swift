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
    //MARK: - Posts
    @Published var posts: [Post] = []
    @Published var isLoadingPosts = false
    @Published var postsError: String?

    //MARK: - Comments
    @Published var comments: [Comment] = []
    @Published var isLoadingComments = false
    @Published var commentsError: String?
    
    func loadPosts() async {
        
        isLoadingPosts = true
        postsError = nil
        
        do {
            posts = try await APIService.shared.fetchPosts()
        } catch {
            self.postsError = error.localizedDescription
        }
        isLoadingPosts = false
    }
    
    func loadComments(for postID: Int) async {
        isLoadingComments = true
        commentsError = nil
        
        do {
            let all = try await APIService.shared.fetchComments(postID: postID)
            comments = Array(all.prefix(3))
        } catch {
            self.commentsError = error.localizedDescription
        }
        isLoadingComments = false
    }
    
}
