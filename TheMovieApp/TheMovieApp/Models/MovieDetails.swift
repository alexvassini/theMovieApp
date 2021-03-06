//
//  MovieDetails.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 20/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

//   let movieDetails = try? newJSONDecoder().decode(MovieDetails.self, from: jsonData)

import Foundation

struct MovieDetails: Codable {
    let adult: Bool
    let budget: Int
    let genres: [Genre]
    let homepage: String?
    let id: Int
    let imdbID: String?
    let originalLanguage, originalTitle: String
    let overview: String?
    let popularity: Double
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue: Int
    let spokenLanguages: [SpokenLanguage]
    let status, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let credits: Credits

    enum CodingKeys: String, CodingKey {
        case adult
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case spokenLanguages = "spoken_languages"
        case status, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case credits
    }
    
    init(credits: Credits) {
        adult = false
        budget = 0
        genres = []
        homepage = ""
        id = 0
        imdbID = ""
        originalLanguage = ""
        originalTitle = ""
        overview = ""
        popularity = 0
        productionCompanies = []
        productionCountries = []
        revenue = 0
        releaseDate = ""
        spokenLanguages = []
        status = ""
        title = ""
        video = false
        voteAverage = 0
        voteCount = 0
        self.credits = credits
    }
}

struct Credits: Codable {
    let cast: [Cast]
    let crew: [Crew]
    
    init(crew: [Crew]) {
        cast = []
        self.crew = crew
    }
}

struct Cast: Codable {
    let castID: Int
    let character, creditID: String
    let gender, id: Int
    let name: String
    let order: Int
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender, id, name, order
        case profilePath = "profile_path"
    }
}

struct Crew: Codable {
    let creditID, department: String
    let gender, id: Int
    let job, name: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case department, gender, id, job, name
        case profilePath = "profile_path"
    }
    
    init(job: String, name: String){
        creditID = ""
        department = ""
        gender = 0
        id = 0
        self.job = job
        self.name = name
        profilePath = ""
    }
}
struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int
    let logoPath, name, originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Codable {
    let iso3166_1, name: String
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguage: Codable {
    let iso639_1, name: String
    
    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
}
