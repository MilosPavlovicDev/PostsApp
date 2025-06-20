//
//  SkeletonView.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 3. 6. 2025..
//

import SwiftUI

struct SkeletonView<S: Shape>: View {
    
    var shape: S
    var color: Color
    init(_ shape: S, _ color: Color = .gray.opacity(0.3)) {
        self.shape = shape
        self.color = color
    }
    @State private var isAnimating: Bool = false
    
    
    var body: some View {
        shape
            .fill(color)
        ///Skeleton effect
            .overlay {
                GeometryReader {
                    let size = $0.size
                    let skeletonWidth = size.width / 2
                    ///Limiting blue radius to 30+
                    let blurRadius = max(skeletonWidth / 2, 30)
                    let blurDiameter = blurRadius * 2
                    ///Movment Offsets
                    let minX = -(skeletonWidth + blurDiameter)
                    let maxX = size.width + skeletonWidth + blurDiameter
                    
                    Rectangle()
                        .fill(.gray)
                        .frame(width: skeletonWidth, height: size.height * 2)
                        .frame(height: size.height)
                        .blur(radius: blurRadius)
                        .rotationEffect(.init(degrees: rotation))
                        .blendMode(.softLight)
                        ///Moving from left-right in-definetely
                        .offset(x: isAnimating ? maxX: minX)
                    
                }
            }
            .clipShape(shape)
            .compositingGroup()
            .onAppear {
                guard !isAnimating else { return }
                withAnimation(animation) {
                    isAnimating = true
                }
            }
            .onDisappear {
                isAnimating = false
            }
            .transaction {
                if $0.animation != animation {
                    $0.animation = .none
                }
            }
    }
    
    var rotation: Double {
        return 5
    }
    var animation: Animation {
        .easeInOut(duration: 1.5).repeatForever(autoreverses: false)
    }
}

enum SkeletonShape {
    case rect(corner: CGFloat = 0)
    case circle
}

extension SkeletonView where S == RoundedRectangle {
    init(_ shape: SkeletonShape, color: Color = .gray.opacity(0.3)) {
        switch shape {
        case .rect(let corner):
            self.init(RoundedRectangle(cornerRadius: corner, style: .continuous), color)
        case .circle:
            self.init(RoundedRectangle(cornerRadius: 999), color) // nikad neće biti vidljiv ugao
        }
    }
}
