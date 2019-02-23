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
    
    init(service: FeedService) {
        self.service = service
    }
    
    func getMovieList() -> Single<[Movie]> {
        return self.service.getPopularMovieList(page: 1)
            .map(MovieList.self)
            .map{$0.movies}
    }
    
    func getMovieDetails(_ movieId: Int) -> Single<MovieDetails> {
        return self.service.getMovieDetails(movieId: movieId).map(MovieDetails.self)
    }
    
}