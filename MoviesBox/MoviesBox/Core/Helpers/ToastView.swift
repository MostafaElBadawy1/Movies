//
//  ToastView.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//

import SwiftUI

@ViewBuilder
func toastView(message: String, onRetry: @escaping () -> Void) -> some View {
    VStack {
        Spacer()
        HStack {
            Text(message)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .multilineTextAlignment(.leading)
            Button("Retry") {
                onRetry()
            }
            .foregroundColor(.yellow)
            .padding(.horizontal, 8)
        }
        .background(Color.red.opacity(0.9))
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding()
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeInOut(duration: 0.3), value: message)
    }
}

