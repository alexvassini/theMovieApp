//
//  Movies.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 20/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import Foundation

struct MovieList: Codable {
    let page, totalResults, totalPages: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}

struct Movie: Codable {
    let id: Int
    let video: Bool
    let voteAverage: Double
    let title: String
    let popularity: Double
    let posterPath: String
    let originalLanguage: String
    let originalTitle: String
    let backdropPath: String?
    let overview, releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
    }
    
    init(originalTitle: String,
         releaseDate: String,
         voteAverage: Double,
         backdropPath: String,
         posterPath:String,
         overview: String,
         id: Int) {
        
        self.id = id
        video = false
        self.voteAverage = voteAverage
        title = ""
        popularity = 0
        self.posterPath = posterPath
        originalLanguage = ""
        self.originalTitle = originalTitle
        self.backdropPath = backdropPath
        self.overview = overview
        self.releaseDate = releaseDate
        
    }
}

struct RequestError: Codable {
    let status_message: String
}


