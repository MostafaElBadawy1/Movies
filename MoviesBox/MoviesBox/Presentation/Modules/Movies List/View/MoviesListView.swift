//
//  MoviesListView.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 26/08/2025.
//

import SwiftUI

struct MoviesListView: View {
    // 1. MARK: - State & Data Properties
    @StateObject var viewModel: MoviesListViewModel
    
    // 2. MARK: - Constants / Layout Properties
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    // 3. MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    switch viewModel.viewState {
                        case .idle, .loading:
                            ProgressView("Loading movies...")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        case .loaded, .paginating:
                            titleView
                            buildList()
                            .navigationDestination(item: $viewModel.selectedMovie) { movie in
                                AppFactory.makeMovieDetailsView(movieId: movie.id)
                            }
                            if viewModel.viewState == .paginating {
                                ProgressView()
                                    .padding()
                            }
                            if let error = viewModel.errorMessage {
                                toastView(message: error) {
                                    viewModel.retry()
                                }
                            }
                    }
                }
            }
        }
        .task {
            await viewModel.fetchMovies()
        }
        .background(Color(.systemBackground))
    }
    
    // 4. MARK: - Subviews / View Builders
    private var titleView: some View {
        Text("MovieBox")
            .foregroundStyle(Color.primary)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.horizontal)
            .padding(.top, 0)
            .frame(maxWidth: .infinity, alignment: .center)
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
    
    @ViewBuilder
    private func buildList() -> some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.movies) { movie in
                    MovieCardView(movie: movie)
                        .onAppear {
                            if movie == viewModel.movies.last {
                                Task { await viewModel.fetchMovies() }
                            }
                        }
                        .onTapGesture {
                            viewModel.selectedMovie = movie
                        }
                }
            }
            .padding()
        }
    }
    
//    @ViewBuilder
//    private func buildErrorView(_ message: String) -> some View {
//        VStack {
//            Text("Failed to load movies: \(message)")
//                .multilineTextAlignment(.center)
//                .padding()
//            Button("Retry") {
//                Task { await viewModel.fetchMovies() }
//            }
//        }
//    }
}


