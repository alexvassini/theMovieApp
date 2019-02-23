//
//  MoviesServiceImpl.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 20/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//


import Foundation
import RxSwift
import Moya


class FeedServiceImpl: NSObject, FeedService {

    let provider: MoyaProvider<FeedRouter>
    
    init(provider: MoyaProvider<FeedRouter> = MoyaProvider<FeedRouter>(plugins: [NetworkLoggerPlugin(verbose: true)])) {
        self.provider = provider
        super.init()
    }
    
    func getMovieDetails(movieId: Int) -> Single<Response> {
        return provider.rx.request(.getMovieDetails(movieId: movieId))
    }
    
    func getPopularMovieList(page: Int) -> Single<Response> {
        return provider.rx.request(.getPopularMovieList(page: page))
    }
  
}
