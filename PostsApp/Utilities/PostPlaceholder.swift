//
//  PostPlaceholder.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 3. 6. 2025..
//

import SwiftUI

struct PostPlaceholder: View {
    let post: Post?
        
        private var isSkeleton: Bool { post == nil }
        
        /// Deterministic thumbnail for each post ID
        private var thumbURL: URL? {
            guard let id = post?.id else { return nil }
            return URL(string: "https://picsum.photos/seed/\(id)/90")
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top, spacing: 12) {
                    
                    // MARK: - Image / Skeleton
                    Group {
                        if isSkeleton {
                            SkeletonView(.rect(corner: 8))
                        } else {
                            AsyncImage(url: thumbURL) { phase in
                                switch phase {
                                case .success(let img): img.resizable()
                                default: SkeletonView(.rect(corner: 8))
                                }
                            }
                        }
                    }
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    // MARK: - Text / Skeletons
                    VStack(alignment: .leading, spacing: 6) {
                        if isSkeleton {
                            SkeletonView(.rect(corner: 4))
                                .frame(width: 120, height: 20)
                            SkeletonView(.rect(corner: 4))
                                .frame(height: 10)
                            SkeletonView(.rect(corner: 4))
                                .frame(width: 150, height: 10)
                        } else {
                            Text(post!.title.capitalized)
                                .foregroundStyle(Color("TitleColor"))
                                .font(.headline)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                            
                            Text(post!.body)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
                .padding(.vertical, 5)
                .padding(.horizontal)
                
                Divider()
                    .background(Color.gray.opacity(0.25))
                    .padding(.leading, 82)
                
            }
            }
    }

