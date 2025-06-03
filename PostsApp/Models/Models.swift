//
//  Models.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 3. 6. 2025..
//

import Foundation

// MARK: - Post
struct Post: Codable, Identifiable {
    let id: Int
    let userId: Int
    var title: String
    var body: String
}

// MARK: -Comment
struct Comment: Codable, Identifiable {
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
}
