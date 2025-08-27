//
//  FavoritesView.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 26/08/2025.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query(sort: \FavoriteMovie.title) private var favorites: [FavoriteMovie]

    var body: some View {
        NavigationStack {
            Group {
                if favorites.isEmpty {
                    ContentUnavailableView("No Favorites", systemImage: "heart", description: Text("Tap the heart on any movie to save it here."))
                } else {
                    List {
                        ForEach(favorites) { movie in
                            NavigationLink {
                                AppFactory.makeMovieDetailsView(movieId: movie.id)
                            } label: {
                                HStack(spacing: 12) {
                                    AsyncImageWrapper(url: movie.posterURLString)
                                        .frame(width: 60, height: 90)
                                        .clipped()
                                        .cornerRadius(6)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(movie.title)
                                            .font(.headline)
                                            .lineLimit(2)
                                        Text("⭐️ \(movie.rating)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text(movie.releaseDate)
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Favorites")
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let fav = favorites[index]
            if let context = fav.modelContext {
                context.delete(fav)
                try? context.save()
            }
            NotificationCenter.default.post(name: .favoriteChanged, object: nil, userInfo: ["id": fav.id, "isFavorite": false])
        }
    }
}


