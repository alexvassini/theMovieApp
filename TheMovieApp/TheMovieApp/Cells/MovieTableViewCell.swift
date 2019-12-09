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

    override func prepareForReuse() {
        movieImage.image = nil
    }
    
    func bind(_ model: MovieTableViewCellViewModel) {
        if let imageUrl = model.getImageURL() {
            movieImage.af_setImage(withURL: imageUrl)
        }
        else {
            movieImage.image = R.image.placeholderImage()
        }
        movieNameLabel.text = model.getMovieNameLabel()
        releaseDateLabel.text = model.getReleaseDateLabel()
        rattingLabel.text = model.getRattingLabel()
        
    }
    
}
