//
//  MockData.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 24/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//
@testable import TheMovieApp
import Foundation

struct MockData {
    
    static let movie = Movie(originalTitle: "A volta dos que não foram",
                      releaseDate: "2018-01-31",
                      voteAverage: 6.8,
                      backdropPath: "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
                      posterPath: "/lFSSLTlFozwpaGlO31OoUeirBgQ.jpg",
                      overview: "The most dangerous former operative of the CIA is drawn out of hiding to uncover hidden truths about his past.",
                      id: 297761)
    
    static let crew1 = Crew(job: "Director", name: "Xôsseff")
    static let crew2 = Crew(job: "Producer", name: "Xisellen")
    static let crew3 = Crew(job: "Camera", name: "Xôana")
    static let crew4 = Crew(job: "Writer", name: "Xislaine")
    static let crew5 = Crew(job: "Producer", name: "Xôaum")
    static let crew6 = Crew(job: "Director", name: "Xôzué")
    
    static let credits = Credits(crew: [
        Crew(job: "Director", name: "Xôsseff"),
        Crew(job: "Producer", name: "Xisellen"),
        Crew(job: "Camera", name: "Xôana"),
        Crew(job: "Writer", name: "Xislaine"),
        Crew(job: "Producer", name: "Xôaum"),
        Crew(job: "Director", name: "Xôzué")])
    
    static let movieDetails = MovieDetails(credits: MockData.credits)
    
}
