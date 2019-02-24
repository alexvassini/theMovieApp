//
//  MovieDetailsViewModel.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 22/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import RxSwift
import RxCocoa

class MovieDetailsViewModel {
    
    let director: Driver<[Crew]>
    let producer: Driver<[Crew]>
    let overview: Driver<String>
    let reviews: Driver<[Review]>
    
    @IBOutlet weak var reviewsStack: UIStackView!
    
    let movie: PublishSubject<Movie> = PublishSubject()
    
    init(repository: FeedRepository = FeedRepositoryImpl()) {
        
        let result = movie.flatMapLatest { (movie) in
            repository.getMovieDetails(movie.id)
        }.materialize()
        
        let movieDetails = result.elements().share()
        
        self.director = movieDetails
            .map{$0.credits.crew}
            .filter{$0.contains{$0.job == "Director"}}
            .asDriver(onErrorJustReturn: [])
        
        self.producer = movieDetails
            .map{$0.credits.crew}
            .filter{$0.contains{$0.job == "Producer"}}
            .asDriver(onErrorJustReturn: [])
        
        self.overview = movieDetails
            .map{$0.overview}
            .unwrap()
            .asDriver(onErrorJustReturn: "")
        .debug("Overview ->>>")
        
        self.reviews = movieDetails
            .map{$0.reviews.results}
            .asDriver(onErrorJustReturn:[])

    }
    
    
}
