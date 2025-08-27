//
//  TabRootView.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 26/08/2025.
//

import SwiftUI
import SwiftData

struct TabRootView: View {
    @StateObject var moviesVM: MoviesListViewModel

    var body: some View {
        TabView {
            NavigationStack {
                MoviesListView(viewModel: moviesVM)
            }
            .tabItem { Label("Movies", systemImage: "film") }

            FavoritesView()
                .tabItem { Label("Favorites", systemImage: "heart") }
        }
        .modelContainer(for: FavoriteMovie.self)
    }
}


