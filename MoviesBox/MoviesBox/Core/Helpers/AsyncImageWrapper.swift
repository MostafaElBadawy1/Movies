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
