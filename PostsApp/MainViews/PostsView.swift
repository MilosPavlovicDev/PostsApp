//
//  ContentView.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 3. 6. 2025..
//

import SwiftUI

struct PostsView: View {
    
    @State private var openCreatePostView = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    postList
                }
                .padding(.top, 20)
                .padding(.horizontal)
                .padding(.bottom, 100) // Extra space so content doesn’t go under the button
            }
            .overlay(createPostButton, alignment: .bottom) // 👈 Overlay directly on ScrollView
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("🧑🏻‍💻 Hello dev's")
                        .bold()
                        .font(.title)
                        .padding(.bottom, 8)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // About action
                    } label: {
                        VStack(spacing: 2) {
                            Image(systemName: "info.circle")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color("SmgColor"))
                            Text("About")
                                .font(.caption)
                                .foregroundColor(Color("SmgColor"))
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $openCreatePostView) {
            CreatePostView()
        }
    }
    
    private var createPostButton: some View {
        Button {
            openCreatePostView = true
        } label: {
            Text("+ Create a post")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color("SmgColor"))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.bottom, 10)
                .shadow(radius: 12)
        }
    }
    
    private var postList: some View {
        ForEach(0..<10, id: \.self) { _ in
            PostPlaceholder()
        }
    }
}


#Preview {
    PostsView()
}
