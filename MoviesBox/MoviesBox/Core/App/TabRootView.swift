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
    @EnvironmentObject private var router: Router
    var body: some View {
        TabView(selection: $router.selectedTab) {
            NavigationStack(path: $router.homePath) {
                MoviesListView(viewModel: moviesVM)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            case .details(let id):
                                AppFactory.makeMovieDetailsView(movieId: id)
                        }
                    }
            }
            .tabItem { Label("Movies", systemImage: "film") }
            NavigationStack(path: $router.favoritesPath) {
                FavoritesView()
                    .tabItem { Label("Favorites", systemImage: "heart") }
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            case .details(let id):
                                AppFactory.makeMovieDetailsView(movieId: id)
                        }
                    }
            }
        }
        .modelContainer(for: FavoriteMovie.self)
    }
}


