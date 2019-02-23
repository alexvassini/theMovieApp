//
//  FeedViewModel.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 21/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftExt
import RxSwiftUtilities


class FeedViewModel {
    
    let repository: FeedRepository
    
    let results: Driver<[Movie]>
    let requestTrigger: PublishSubject<Void> = PublishSubject()
    
    init(repository: FeedRepository ) {
        
        self.repository = repository
        
        let response = requestTrigger
            .flatMapLatest { _ in
            repository.getMovieList()
                .debug("->>>>>>>")
        }.materialize()
        
        self.results = response
            .elements()
            .asDriver(onErrorJustReturn: [])
        
    }

}
