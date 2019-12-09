//
//  SearchViewModel.swift
//  TheMovieApp
//
//  Created by Alexandre  Vassinievski on 07/12/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftUtilities
import Moya

class SearchViewModel {

    private let repository: FeedRepository

    let results: Driver<[Movie]>
    let isLoading: Driver<Bool>
    let requestTrigger: PublishSubject<String> = PublishSubject()

    init(repository: FeedRepository = FeedRepositoryImpl()) {

        self.repository = repository

        let loadingIndicator = ActivityIndicator()

        self.isLoading = loadingIndicator
            .startWith(false)
            .asDriver()

        let response = requestTrigger
            .flatMapLatest { query in
                repository.searchMovies(query: query, page: 1)
                    .trackActivity(loadingIndicator)
                    .materialize()
        }

        let moviesResult = response
            .elements()
            .startWith([])

        self.results = moviesResult.asDriver(onErrorJustReturn: [])
    }

    func doSomething(query: String) {
        requestTrigger.onNext(query)
    }
}

