//
//  DetailPostView.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 4. 6. 2025..
//

import SwiftUI

struct DetailPostView: View {
    
    let post: Post?
    private var isSkeleton: Bool { post == nil }
    
    // Hero image URL ­– deterministic per-ID
    private var thumbURL: URL? {
        guard let id = post?.id else { return nil }
        return URL(string: "https://picsum.photos/seed/\(id)/800/450")
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    if isSkeleton {
                        SkeletonView(.rect(corner: 16))
                            .aspectRatio(16/9, contentMode: .fit)
                    } else {
                        AsyncImage(url: thumbURL) { phase in
                            switch phase {
                            case .success(let img):
                                img
                                    .resizable()
                            default:
                                SkeletonView(.rect(corner: 16))
                                    .aspectRatio(16/9, contentMode: .fit)
                            }
                        }
                        .aspectRatio(16/9, contentMode: .fit)
                    }
                }
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                
                // ---------- Title ----------
                Text(post!.title.capitalized)
                    .font(.title2).bold()
                
                // ---------- Body ----------
                Text(post!.body)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Spacer(minLength: 32)
            }
            .padding()
        }
        .navigationTitle("Post details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailPostView(
        post: Post(id: 1, userId: 1,
                   title: "Preview Title",
                   body: "Preview body lorem ipsum dolor sit amet."))
}
