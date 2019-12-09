//
//  FeedViewModel.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 21/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftUtilities


class FeedViewModel {
    
    let repository: FeedRepository
    
    let results: Driver<[Movie]>
    var isLoading: Driver<Bool>
    let requestTrigger: PublishSubject<Void> = PublishSubject()
    
    init(repository: FeedRepository = FeedRepositoryImpl()) {
        
        self.repository = repository
        
       let loadingIndicator = ActivityIndicator()
        
        self.isLoading = loadingIndicator
            .startWith(false)
            .asDriver()
        
        let currentPage = BehaviorSubject<Int>(value: 1)
        
        let response = requestTrigger
            .withLatestFrom(isLoading)
            .filter { $0 == false }
            .withLatestFrom(currentPage)
            .flatMapLatest { page in
                repository.getMovieList(page: page)
                .do(onSuccess: { _ in currentPage.onNext(page + 1) } )
                .trackActivity(loadingIndicator)
            }.materialize()
        
        let moviesResult = response
            .elements()
            .startWith([])
        
        self.results = moviesResult.scan([], accumulator: +).asDriver(onErrorJustReturn: [])
        
    }
    
}
