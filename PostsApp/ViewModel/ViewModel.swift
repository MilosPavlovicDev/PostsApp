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
    
    //MARK: - Create Post
    @Published var isSubmittingPost = false
    @Published var submitError: String?
    
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
    
   
    func createPost(title: String, body: String) async -> Bool {
            isSubmittingPost = true
            submitError = nil
            do {
                let serverPost = try await APIService.shared.createPost(title: title, body: body)
                // Generate a unique local ID
                let nextID = (posts.map(\.id).max() ?? 0) + 1
                // Make a brand-new Post with that ID
                let localPost = Post(id: nextID,
                                     userId: serverPost.userId,
                                     title: serverPost.title,
                                     body: serverPost.body)
                // Insert at the top of the list
                posts.insert(localPost, at: 0)
                isSubmittingPost = false
                return true
            } catch {
                submitError = error.localizedDescription
                isSubmittingPost = false
                return false
            }
        }
    
}
