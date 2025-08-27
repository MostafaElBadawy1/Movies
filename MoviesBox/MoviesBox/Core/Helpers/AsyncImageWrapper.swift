//
//  AsyncImageWrapper.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//

import SwiftUI

struct AsyncImageWrapper: View {
    let url: String

    var body: some View {
        if let cachedImage = AsyncImageWrapper.cache[url] {
            cachedImage
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            AsyncImage(url: URL(string: url)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let downloadedImage):
                    downloadedImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onAppear { cache(downloadedImage) }
                case .failure(let error):
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
        }
    }

    private func cache(_ image: Image) {
        AsyncImageWrapper.cache[url] = image
    }

    // Memory Cache
    static var cache: [String: Image] = [:]
}
