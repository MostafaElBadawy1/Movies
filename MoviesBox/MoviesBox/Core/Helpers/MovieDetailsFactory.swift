//
//  MovieDetailsFactory.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 26/08/2025.
//

import Foundation

enum MovieDetailsFactory {
    static func makeView(movieId: Int) -> MovieDetailsView {
        let repo = MovieDetailsRepositoryImpl()
        let useCase = FetchMovieDetailsUseCaseImpl(repository: repo)
        let vm = MovieDetailsViewModel(movieId: movieId, fetchMovieDetailsUseCase: useCase)
        return MovieDetailsView(viewModel: vm)
    }
}


