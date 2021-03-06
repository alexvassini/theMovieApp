//
//  MoviesService.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 20/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol FeedService {

    func getMovieDetails(movieId: Int) -> Single<Response>
    func getPopularMovieList(page: Int) -> Single<Response>
    func searchMovies(query: String, page: Int) -> Single<Response>
}
