//
//  AsyncImageWrapper.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//

import SwiftUI
import UIKit
import ImageIO
import UniformTypeIdentifiers

struct AsyncImageWrapper: View {
    let url: String
    let maxDimension: CGFloat

    @State private var uiImage: UIImage?

    init(url: String, maxDimension: CGFloat = 320) {
        self.url = url
        self.maxDimension = maxDimension
    }

    var body: some View {
        Group {
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .interpolation(.medium)
                    .antialiased(true)
                    .transition(.opacity)
            } else {
                ProgressView()
            }
        }
        .task(id: url) {
            await load()
        }
    }

    @MainActor
    private func setImage(_ image: UIImage?) {
        self.uiImage = image
    }

    private func load() async {
        guard uiImage == nil, let imageURL = URL(string: url), !url.isEmpty else { return }
        if let cached = AsyncImageWrapper.cache.object(forKey: url as NSString) {
             setImage(cached)
            return
        }
        do {
            let request = URLRequest(url: imageURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
            let (data, _) = try await URLSession.shared.data(for: request)
            let downsampled = downsample(data: data, maxDimension: Int(maxDimension * UIScreen.main.scale))
            if let downsampled { AsyncImageWrapper.cache.setObject(downsampled, forKey: url as NSString) }
             setImage(downsampled)
        } catch {
             setImage(nil)
        }
    }

    private func downsample(data: Data, maxDimension: Int) -> UIImage? {
        let options: [NSString: Any] = [
            kCGImageSourceShouldCache: false,
            kCGImageSourceTypeIdentifierHint: UTType.jpeg.identifier as NSString
        ]
        guard let source = CGImageSourceCreateWithData(data as CFData, options as CFDictionary) else { return UIImage(data: data) }
        let downsampleOptions: [NSString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimension,
            kCGImageSourceCreateThumbnailWithTransform: true
        ]
        guard let cgImage = CGImageSourceCreateThumbnailAtIndex(source, 0, downsampleOptions as CFDictionary) else {
            return UIImage(data: data)
        }
        return UIImage(cgImage: cgImage)
    }

    private static let cache = NSCache<NSString, UIImage>()
}
struct OptimizedImageView: View {
    let url: URL
  //  let targetSize: CGSize
    
    var body: some View {
        if let cachedImage = OptimizedImageView.cache[url] {
            cachedImage
                .resizable()
                .aspectRatio(contentMode: .fit)
        }  else {
                AsyncImage(url: url) { phase in
                    switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                              .onAppear { cache(image) }
                            // .frame(width: targetSize.width, height: targetSize.height)
                                .clipped()
                        case .failure(_):
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        case .empty:
                            ProgressView()
                            // .frame(width: targetSize.width, height: targetSize.height)
                        @unknown default:
                            EmptyView()
                    }
                }
            }
    }
    private func cache(_ image: Image) {
        OptimizedImageView.cache[url] = image
    }
    
    // Memory Cache
    static var cache: [URL: Image] = [:]
}
