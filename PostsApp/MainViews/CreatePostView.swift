//
//  CreatePostView.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 3. 6. 2025..
//

import SwiftUI
import UIKit

struct CreatePostView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: ViewModel
    @Binding var isPresented: Bool
    @State private var title: String = ""
    @State private var bodyText: String = ""
    @State private var showConfirm: Bool = false
    
    private var formIsValid: Bool {
        !title.isEmpty && !bodyText.isEmpty && !vm.isSubmittingPost
    }

    var body: some View {
        NavigationStack {
            GeometryReader { _ in
                ZStack {
                    // Background to match Form's default light gray
                    Color(UIColor.systemGroupedBackground)
                        .ignoresSafeArea()
                    
                    VStack(alignment: .leading) {
                        if showConfirm {
                            ConfirmLottieView(isPresented: $isPresented)
                        } else {
                            Form {
                                Section("STEP 1: ADD TITLE") {
                                    TextField("Enter title", text: $title)
                                }
                                Section("STEP 2: ADD CONTEXT") {
                                    TextEditor(text: $bodyText)
                                        .frame(minHeight: 120)
                                }
                            }
                        }
                    }
                    .overlay(alignment: .bottom) {
                        submitButton
                    }
                    .navigationTitle("New Post")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { dismiss() }
                        }
                    }
                    .alert("Error", isPresented: .constant(vm.submitError != nil)) {
                        Button("OK") { vm.submitError = nil }
                    } message: {
                        Text(vm.submitError ?? "")
                    }
                }
                .onTapGesture(perform: { hideKeyboard() })
                .ignoresSafeArea(.keyboard)
            }
        }
    }
    
    private var submitButton: some View {
        Button(action: { Task { await submit() } }) {
            HStack {
                if vm.isSubmittingPost {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .tint(.white)
                }
                Text(vm.isSubmittingPost ? "Submitting…" : "Submit Post")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(
                formIsValid && !vm.isSubmittingPost ? Color("SmgColor") : .gray.opacity(0.4)
            )
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.bottom, 10)
            .shadow(radius: 12)
            .offset(y: vm.isSubmittingPost ? 0 : (showConfirm ? 200 : 0))
        }
        .disabled(!formIsValid || vm.isSubmittingPost)
        .animation(.easeInOut(duration: 0.5), value: showConfirm)
    }

    private func submit() async {
        let ok = await vm.createPost(title: title, body: bodyText)
        if ok {
            withAnimation {
                showConfirm = true // Show animation, dismissal handled by ConfirmLottieView
            }
        }
    }
}

extension View {
    /// Hides the keyboard for any UIResponder on screen.
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

#Preview {
    CreatePostView(vm: ViewModel(), isPresented: .constant(true))
}
