//
//  ContentView.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 3. 6. 2025..
//

import SwiftUI

struct PostsView: View {
    
    @State private var openCreatePostView = false
    @State private var showAboutView = false
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    postList
                }
                .padding(.top, 20)
                .padding(.bottom, 100)
            }
            .navigationDestination(isPresented: $showAboutView) { AboutView() }
            .overlay(createPostButton, alignment: .bottom)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("🧑🏻‍💻 Hello dev's")
                        .bold()
                        .font(.title)
                        .padding(.bottom, 8)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAboutView = true
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
            .task { if vm.posts.isEmpty { await vm.loadPosts() } }
        }
        
        .fullScreenCover(isPresented: $openCreatePostView) {
            CreatePostView(vm: vm, isPresented: $openCreatePostView)
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
    
    @ViewBuilder
    private var postList: some View {
        if vm.isLoadingPosts {
            skeletonRows
        } else if let message = vm.postsError {
            errorView(message)
        } else {
            postRows
        }
    }
    
    private var skeletonRows: some View {
        ForEach(0..<8, id: \.self) { _ in
            PostPlaceholder(post: nil)
        }
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 12) {
            Text("Failed to load posts 🥲")
            Text(message).font(.caption).foregroundColor(.secondary)
            Button("Retry") { Task { await vm.loadPosts() } }
        }
        .frame(maxWidth: .infinity, minHeight: 300)
    }
    
    
    private var postRows: some View {
        ForEach(vm.posts) { post in
            NavigationLink {
                DetailPostView(post: post, vm: vm)
            } label: {
                    PostPlaceholder(post: post)
            }
        }
    }
}


#Preview {
    PostsView()
}
