//
//  AppFactory.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 27/08/2025.
//


import Foundation
import SwiftUI

enum AppFactory {
    @MainActor
    static func makeMoviesListViewModel() -> MoviesListViewModel {
        let repo = MoviesListRepositoryImpl()
        let useCase = FetchTopRatedMoviesUseCaseImpl(repository: repo)
        return MoviesListViewModel(fetchTopRatedMoviesUseCase: useCase)
    }

    @MainActor
    static func makeRoot() -> TabRootView {
        let vm = makeMoviesListViewModel()
        return TabRootView(moviesVM: vm)
    }

    @MainActor
    static func makeMovieDetailsView(movieId: Int) -> MovieDetailsView {
        let repo = MovieDetailsRepositoryImpl()
        let useCase = FetchMovieDetailsUseCaseImpl(repository: repo)
        let vm = MovieDetailsViewModel(movieId: movieId, fetchMovieDetailsUseCase: useCase)
        return MovieDetailsView(viewModel: vm)
    }
}