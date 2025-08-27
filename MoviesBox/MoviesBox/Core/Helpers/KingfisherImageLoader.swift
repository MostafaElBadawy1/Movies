//
//  KingfisherImageLoader.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//


import UIKit
import Kingfisher

protocol ImageLoader {
    func loadImage(from url: URL?, into imageView: UIImageView?, placeholder: UIImage?)
}


final class KingfisherImageLoader: ImageLoader {
     func loadImage(from url: URL?, into imageView: UIImageView?, placeholder: UIImage? = nil) {
         DispatchQueue.main.async {
             imageView?.kf
                 .setImage(
                    with: url,
                    placeholder: placeholder,
                    options: [.cacheOriginalImage]
                 )
         }
    }
}
