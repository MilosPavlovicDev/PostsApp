//
//  DetailPostView.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 4. 6. 2025..
//

import SwiftUI

struct DetailPostView: View {
    
    let post: Post
    private var isSkeleton: Bool { post == nil }
    @StateObject var vm: ViewModel
    
    private var thumbURL: URL? {
        let id = post.id
        return URL(string: "https://picsum.photos/seed/\(id)/800/450")
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
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
                    
                    Text(post.title.capitalized)
                        .font(.title2).bold()
                    
                    Text(post.body)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Text("Comments")
                        .font(.title2)
                        .bold()

                    Group {
                        if vm.isLoadingComments {
                            ForEach(0..<3, id: \.self) { _ in
                                CommentPlaceholder(comment: nil)
                            }
                        } else if let err = vm.commentsError {
                            Text(err)
                                .foregroundColor(.red)
                                .font(.footnote)
                        } else if vm.comments.isEmpty {
                            HStack(alignment: .center) {
                                Spacer()
                                Text("No comments for this post 🥲")
                                    .font(.caption).foregroundColor(.secondary)
                                Spacer()
                            }
                        } else {
                            ForEach(vm.comments) { comment in
                                CommentPlaceholder(comment: comment)
                            }
                        }
                    }
                
                }
                .padding()
            }
        }
        .task { await vm.loadComments(for: post.id) }
        .navigationTitle("Post details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

