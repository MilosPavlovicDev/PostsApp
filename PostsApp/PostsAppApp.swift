//
//  PostsAppApp.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 3. 6. 2025..
//

import SwiftUI

@main
struct PostsAppApp: App {
    
    // MARK: - Global state objects
    @StateObject private var netService = InternetConnectionService()
    @StateObject private var postsVM = ViewModel()
    
    // MARK: - Splash
    @State private var showSplash = true
    private let minSplash: TimeInterval = 2.0
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                
                // Main content
                PostsView()
                    .opacity(showSplash ? 0 : 1)
                    .disabled(!netService.isConnected)
                    .environmentObject(postsVM)
                
                // Splash
                if showSplash {
                    LoadingView(isLoading: $showSplash)
                        .transition(.opacity)
                }
                
                // No-internet overlay
               if !netService.isConnected && !showSplash {
                    NoInternetOverlayView { netService.refresh() }
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
            .task { await startUp() }
            .environmentObject(netService)
        }
    }
    
    // MARK: - App start-up sequence
    @MainActor
    private func startUp() async {
        async let _ = postsVM.loadPosts()
        try? await Task.sleep(for: .seconds(minSplash))
        withAnimation { showSplash = false }
    }
}
