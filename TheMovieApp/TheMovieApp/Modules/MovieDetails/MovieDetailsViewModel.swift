//
//  MovieDetailsViewModel.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 22/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftExt
import RxSwiftUtilities
import Moya

class MovieDetailsViewModel {
    
    let director: Driver<[String]>
    let producer: Driver<[String]>
    let reviews: Driver<[Review]>
    let error: Observable<RequestError?>
    let isLoading: Driver<Bool>
    let repository: FeedRepository
    
    let movie: PublishSubject<Movie> = PublishSubject()
    
    init(repository: FeedRepository = FeedRepositoryImpl()) {
        
        self.repository = repository
    
        let loadingIndicator = ActivityIndicator()
        
        self.isLoading = loadingIndicator
            .startWith(false)
            .asDriver()
        
        let result = movie.flatMapLatest { (movie) in
            repository.getMovieDetails(movie.id)
        }.materialize()
        
        let movieDetails = result.elements().share()
        
        self.director = movieDetails
            .map{$0.credits.crew}
            .map{$0.filter{$0.job == "Director"}}
            .map{$0.map{$0.name}}
            .asDriver(onErrorJustReturn: [])
        
        self.producer = movieDetails
            .map{$0.credits.crew}
            .map{$0.filter{$0.job == "Producer"}}
            .map{$0.map{$0.name}}
            .asDriver(onErrorJustReturn: [])
        
        self.reviews = movieDetails
            .map{$0.reviews.results}
            .asDriver(onErrorJustReturn:[])
        
       self.error  = result
            .errors()
            .map { $0 as? MoyaError }
            .unwrap()
            .mapError(RequestError.self)
    
    }

}




