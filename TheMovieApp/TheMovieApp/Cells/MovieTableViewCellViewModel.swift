//
//  MovieTableViewCellViewModel.swift
//  TheMovieApp
//
//  Created by Alexandre  Vassinievski on 03/12/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//
import Foundation

class MovieTableViewCellViewModel {

    private let movie: Movie
    private let imageBaseURL = "https://image.tmdb.org/t/p/w1280"

    init (movie: Movie) {
        self.movie = movie
    }

    func getMovieNameLabel() -> String {
        return movie.originalTitle
    }

    func getReleaseDateLabel() -> String {
           return movie.releaseDate
       }

    func getRattingLabel() -> String {
        return "⭐️\(movie.voteAverage)"
    }

    func getImageURL() -> URL? {
        guard let path = movie.backdropPath else { return nil}
        return URL(string: (imageBaseURL + path))
    }
    
}
