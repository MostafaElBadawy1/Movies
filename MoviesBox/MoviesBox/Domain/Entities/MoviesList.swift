//
//  MovieListItem.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 25/08/2025.
//

import Foundation
struct MoviesList: Identifiable, Equatable {
    var id = UUID()
    let movies: [MovieListItem]
    let page: Int
    let totalPages: Int
}
struct MovieListItem: Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let posterURL: URL?
    let rating: String
    let releaseDate: String
}
//- Add to favorites option
