//
//  CommentsPlaceholder.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 4. 6. 2025..
//

import SwiftUI

struct CommentPlaceholder: View {
    let comment: Comment?
    private var isSkeleton: Bool { comment == nil }
    
    
    private var initials: String {
        guard let words = comment?.name.split(separator: " ").prefix(2) else { return "" }
        return words.compactMap { $0.first }.map { String($0) }.joined().uppercased()
    }
    
    private var displayName: String {
        guard let name = comment?.name else { return "" }
        return name
            .split(separator: " ")
            .prefix(2)
            .joined(separator: " ")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                
                // ---------- Avatar / Skeleton ----------
                Group {
                    if isSkeleton {
                        SkeletonView(SkeletonShape.circle)
                    } else {
                        Circle()
                            .fill(Color.blue.opacity(0.15))
                            .overlay(
                                Text(initials)
                                    .font(.caption.bold())
                                    .foregroundColor(.blue)
                            )
                    }
                }
                .frame(width: 34, height: 34)
                
                // ---------- Texts / Skeletons ----------
                VStack(alignment: .leading, spacing: 4) {
                    if isSkeleton {
                        SkeletonView(.rect(corner: 4))
                            .frame(width: 120, height: 14)
                        SkeletonView(.rect(corner: 4))
                            .frame(width: 160, height: 10)
                        SkeletonView(.rect(corner: 4))
                            .frame(height: 10)
                    } else if let c = comment {
                        Text(displayName)
                            .font(.subheadline.weight(.semibold))
                            .lineLimit(1)
                        
                        Text(c.email)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        
                        Text(c.body)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.vertical, 8)
            
            Divider()
                .background(Color.gray.opacity(0.25))
        }
        .padding(.horizontal, 4)
    }
}

#Preview {
    VStack {
        CommentPlaceholder(comment: nil)   // skeleton
        CommentPlaceholder(comment: Comment(
            id: 1,
            postId: 1,
            name: "fugit labore quia mollitia quas deserunt nostrum sunt",
            email: "latin@ipsum.dev",
            body: "Magnam pariatur molestiae recusandae tempora aliquam."))
    }
    .padding()
}

