//
//  AboutView.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 4. 6. 2025..
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .center, spacing: 16) {
                    Image("avatar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Milos Pavlovic")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("nickname: pakidev")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("github: MilosPavlovicDev")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                    }
                }
                .padding()
                VStack {
                    Text("""
Thank you, SMG, for this opportunity to show you what I can build in a short time frame. This was a homework assessment and the third part of the recruitment process. I hope I covered everything in this project that was requested by the company.

I added some of my personal touch so this project actually feels like a real app.

It’s very hard finishing an app like this because I see the potential and just want to keep adding new features, but I think this is just enough. So I hope you like it and that this app gets me one step closer to a position at the company!
""")
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineSpacing(4)
                    
                }
                .padding()
                
            }
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
#Preview {
    AboutView()
}
