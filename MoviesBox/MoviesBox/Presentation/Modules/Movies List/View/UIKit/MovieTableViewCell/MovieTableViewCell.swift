//
//  MovieTableViewCell.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 14/05/2025.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MovieTableViewCell"
    private var imageLoader: ImageLoader?
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: MovieListItem, imageLoader: ImageLoader) {
       // self.imageLoader = imageLoader
        ratingLabel.text = "\(model.rating)"
        releaseDateLabel.text = "\(model.releaseDate)"
        nameLabel.text = model.title
        DispatchQueue.main.async { [weak self] in
            self?.movieImage.kf.setImage(with: model.posterURL)
          //  imageLoader.loadImage(from: model.posterURL, into: self.movieImage, placeholder: UIImage(named: "placeholder"))
        }
    }
}
