//
//  LoadingView.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 3. 6. 2025..
//

import SwiftUI
import UIKit

struct LoadingView: View {
    @Binding var isLoading: Bool
    @State private var animate = false

    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: .systemMaterialLight)
                .ignoresSafeArea()
            VStack {
                Image("smglogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .scaleEffect(animate ? 1.05 : 1)
                    .opacity(animate ? 1 : 0.6)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)

            }
        }
        .onAppear {
            animate = true
        }
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
