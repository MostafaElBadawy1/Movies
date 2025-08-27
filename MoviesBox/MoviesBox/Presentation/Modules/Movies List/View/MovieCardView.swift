//
//  MovieCardView.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 26/08/2025.
//

import SwiftUI
import SwiftData
import Combine

struct MovieCardView: View {
    let movie: MovieListItem
    @Environment(\.modelContext) private var modelContext
    @State private var isFavorite = false
    @State private var favoriteObject: FavoriteMovie?
    @State private var notificationCancellable: AnyCancellable?
    var body: some View {
        VStack(spacing: 8) {
            AsyncImageWrapper(
                url: movie.posterURL?.absoluteString ?? ""
            )
            .scaledToFill()
            .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
            .clipped()
            .cornerRadius(10)
            .shadow(radius: 4)
            
            VStack(spacing: 6) {
                Text(movie.title)
                    .font(.headline)
                    .bold()
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("⭐️ \(movie.rating)")
                    .font(.caption)
                
                Text(movie.releaseDate)
                    .font(.caption2)
            }
            .foregroundColor(.white)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .frame(minHeight: 110, maxHeight: 110)
            .background(Color.black.opacity(0.8))
            .cornerRadius(8)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .overlay(alignment: .topTrailing) {
            Button { toggleFavorite() } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .primary)
                    .padding(8)
                    .background(Color.white.opacity(0.95))
                    .clipShape(Circle())
                    .shadow(radius: 2)
            }
            .padding(10)
        }
        .shadow(radius: 3)
        .frame(maxWidth: .infinity)
        //.frame(minHeight: 200 + 16 + 96 + 16, maxHeight: 200 + 16 + 96 + 16)
        .onAppear {
            refreshFavoriteState()
            notificationCancellable = NotificationCenter.default.publisher(for: .favoriteChanged)
                .sink { notification in
                    guard let userInfo = notification.userInfo as? [String: Any],
                          let changedId = userInfo["id"] as? Int,
                          changedId == movie.id,
                          let isFav = userInfo["isFavorite"] as? Bool else { return }
                    self.isFavorite = isFav
                    if !isFav { self.favoriteObject = nil }
                }
        }
        .onDisappear {
            notificationCancellable?.cancel()
            notificationCancellable = nil
        }
    }

    private func refreshFavoriteState() {
        let id = movie.id
        var descriptor = FetchDescriptor<FavoriteMovie>(predicate: #Predicate { $0.id == id })
        descriptor.fetchLimit = 1
        if let existing = try? modelContext.fetch(descriptor).first {
            favoriteObject = existing
            isFavorite = true
        } else {
            favoriteObject = nil
            isFavorite = false
        }
    }

    private func toggleFavorite() {
        if isFavorite {
            if let favoriteObject {
                modelContext.delete(favoriteObject)
                try? modelContext.save()
            }
            favoriteObject = nil
            isFavorite = false
            NotificationCenter.default.post(name: .favoriteChanged, object: nil, userInfo: ["id": movie.id, "isFavorite": false])
        } else {
            let favorite = FavoriteMovie.from(movie)
            modelContext.insert(favorite)
            try? modelContext.save()
            favoriteObject = favorite
            isFavorite = true
            NotificationCenter.default.post(name: .favoriteChanged, object: nil, userInfo: ["id": movie.id, "isFavorite": true])
        }
    }
}

//#Preview {
//    MovieItem(movie: MovieListItem(id: 1, title: "GodFather", posterURL: nil, rating: 8.0, releaseDate: Date()))
//}


