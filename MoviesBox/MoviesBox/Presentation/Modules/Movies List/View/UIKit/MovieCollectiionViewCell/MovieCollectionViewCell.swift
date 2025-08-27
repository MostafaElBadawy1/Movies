//
//  MovieCollectionViewCell.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 16/05/2025.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieRating.text = "asasasasas"
        movieReleaseDate.text = "asasasasasasasasas"
        movieName.text = "model.title"
    }
    func configure(with model: MovieListItem) {
        // self.imageLoader = imageLoader
        movieRating.text = "asasasasas"
        movieReleaseDate.text = "asasasasasasasasas"
        movieName.text = "model.title"
//        movieRating.text = "\(model.rating)"
//        movieReleaseDate.text = "\(model.releaseDate)"
//        movieName.text = model.title
//        DispatchQueue.main.async { [weak self] in
//            self?.movieImageView.kf.setImage(with: model.posterURL)
//            //  imageLoader.loadImage(from: model.posterURL, into: self.movieImage, placeholder: UIImage(named: "placeholder"))
//        }
    }
}
