//
//  MovieTableViewCell.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 21/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rattingLabel: UILabel!
    
    let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(_ movie: Movie) {
        if let imageUrl = URL(string: (imageBaseURL + movie.backdropPath)){
            movieImage.af_setImage(withURL: imageUrl)
        }
        else {
            //put placeholder
            
        }
        movieNameLabel.text = movie.originalTitle
        releaseDateLabel.text = movie.releaseDate
        rattingLabel.text = "\(movie.voteAverage)"
        
    }
    
}
