//
//  APIService.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 3. 6. 2025..
//

import Foundation

enum APIError: Error { case badURL, decoding, server }

struct APIService {
    static let shared = APIService()
    private init() {}

    //for posts
    func fetchPosts() async throws -> [Post] {

           #if DEBUG
           // 🐌 I intentionally slow down the “network”
           // so devs can admire the fancy skeleton shimmer.
        try? await Task.sleep(for: .seconds(3.5))
           #endif

           guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
           else { throw URLError(.badURL) }

           let (data, _) = try await URLSession.shared.data(from: url)
           return try JSONDecoder().decode([Post].self, from: data)
       }
    
    //for comments
    func fetchComments(postID: Int) async throws -> [Comment] {
        #if DEBUG
        try? await Task.sleep(for: .seconds(1.0))
        #endif
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postID)/comments")
        else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Comment].self, from: data)
    }
}
