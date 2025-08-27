//
//  FavoriteMovie.swift
//  MoviesBox
//
//  Restored on 26/08/2025.
//

import Foundation
import SwiftData

@Model
final class FavoriteMovie {
    @Attribute(.unique) var id: Int
    var title: String
    var posterURLString: String
    var rating: String
    var releaseDate: String

    init(id: Int, title: String, posterURLString: String, rating: String, releaseDate: String) {
        self.id = id
        self.title = title
        self.posterURLString = posterURLString
        self.rating = rating
        self.releaseDate = releaseDate
    }
}

extension FavoriteMovie {
    static func from(_ item: MovieListItem) -> FavoriteMovie {
        FavoriteMovie(
            id: item.id,
            title: item.title,
            posterURLString: item.posterURL?.absoluteString ?? "",
            rating: item.rating,
            releaseDate: item.releaseDate
        )
    }
}


