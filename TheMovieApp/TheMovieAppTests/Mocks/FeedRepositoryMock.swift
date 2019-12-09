//
//  FeedRepositoryMock.swift
//  TheMovieAppTests
//
//  Created by Alexandre Vassinievski Ribeiro on 24/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

@testable import TheMovieApp
import Foundation
import RxSwift
import Moya

enum MockError: Error {
    case generic
}

class FeedRepositoryMock {
    
    var getMovieListInvokedCount = 0
    var getMovieDetailsInvokedCount = 0
    var searchMoviesInvokedCount = 0
    var success = true
    var repositoryHandler: (()->Void)?
}

extension FeedRepositoryMock: FeedRepository {

    func getMovieList(page: Int) -> Single<[Movie]> {
        self.getMovieListInvokedCount += 1
        var result:[Movie] = []
        if success {
            result.append(MockData.movie)
            return .just(result)
        }
        else {
            let subject = PublishSubject<[Movie]>()
            subject.onError(MockError.generic)
            return subject.asSingle()
        }
    }


    func searchMovies(query: String, page: Int) -> Single<[Movie]> {
        return .just([MockData.movie])
    }

    func getMovieDetails(_ movieId: Int) -> Single<MovieDetails> {
        self.getMovieDetailsInvokedCount += 1
        if success {
            return .just(MockData.movieDetails)
        }
        else{
            let subject = PublishSubject<MovieDetails>()
            subject.onError(MockError.generic)
            return subject.asSingle()
        }
    }
}
