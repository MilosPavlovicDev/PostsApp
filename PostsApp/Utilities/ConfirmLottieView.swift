//
//  ConfirmLottieView.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 4. 6. 2025..
//

import SwiftUI
import Lottie

struct ConfirmLottieView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                SuccessLottieAnimation(filename: "ConfirmSmg", completed: $isPresented)
                    .frame(width: 220, height: 220)
                    .padding(.horizontal)
                Spacer()
            }
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct SuccessLottieAnimation: UIViewRepresentable {
    let filename: String
    @Binding var completed: Bool
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play { finished in
            if finished {
                DispatchQueue.main.async {
                    completed = false
                }
            }
        }
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    ConfirmLottieView(isPresented: .constant(true))
}
