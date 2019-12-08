//
//  FeedRepositoryImpl.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 20/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class FeedRepositoryImpl: FeedRepository {

    let service: FeedService
    
    init(service: FeedService = FeedServiceImpl()) {
        self.service = service
    }
    
    func getMovieList(page: Int) -> Single<[Movie]> {
       
        return self.service.getPopularMovieList(page: page)
            .map(MovieList.self)
            .map{$0.movies}
    }
    
    func getMovieDetails(_ movieId: Int) -> Single<MovieDetails> {
        return self.service.getMovieDetails(movieId: movieId).map(MovieDetails.self)
    }

    func searchMovies(query: String, page: Int) -> Single<[Movie]> {

        return self.service.searchMovies(query: query, page: page)
                   .map(MovieList.self)
                   .map{$0.movies}
    }
}
