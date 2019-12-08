//
//  MoviesRepository.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 20/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import RxSwift
import Moya


protocol FeedRepository: class {
    
    func getMovieList(page: Int) -> Single<[Movie]>
    
    func searchMovies(query: String, page: Int) -> Single<[Movie]>
    
    func getMovieDetails(_ movieId: Int) -> Single<MovieDetails>
    
}
