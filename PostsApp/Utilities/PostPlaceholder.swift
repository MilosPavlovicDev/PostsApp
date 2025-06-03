//
//  PostPlaceholder.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 3. 6. 2025..
//

import SwiftUI

struct PostPlaceholder: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 70, height: 70)
            
            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 20)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 10)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 10)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview {
    PostPlaceholder()
}
