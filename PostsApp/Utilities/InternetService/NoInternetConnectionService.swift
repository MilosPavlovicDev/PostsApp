//
//  NoInternetConnectionService.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 3. 6. 2025..
//

import SwiftUI

struct NoInternetOverlayView: View {
    var retryAction: () -> Void

    var body: some View {
        Color.black.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack(spacing: 20) {
                    Image(systemName: "wifi.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                    Text("No Internet Connection")
                        .foregroundColor(.white)
                        .font(.title)
                    Button(action: {
                        retryAction()
                    }) {
                        Text("Retry")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("SmgColor"))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                }
                .padding()
            )
    }
}
