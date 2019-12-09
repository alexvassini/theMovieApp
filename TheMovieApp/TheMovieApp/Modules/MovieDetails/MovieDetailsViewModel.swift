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

    private let repository: FeedRepository
    let movie: Movie
    private let imageBaseURL = "https://image.tmdb.org/t/p/w1280"
    private let posterBaseURL = "https://image.tmdb.org/t/p/w500"
    private let fetchMovieData: PublishSubject<Int> = PublishSubject()

    let director: Driver<[String]>
    let producer: Driver<[String]>
    let budget: Driver<String>
    let revenue: Driver<String>
    let error: Observable<RequestError?>
    let isLoading: Driver<Bool>

    
    init(movie: Movie,
         repository: FeedRepository = FeedRepositoryImpl()) {

        self.repository = repository
        self.movie = movie

        let loadingIndicator = ActivityIndicator()
        
        self.isLoading = loadingIndicator
            .startWith(false)
            .asDriver()

        let result = fetchMovieData
            .flatMapLatest { id in
                repository.getMovieDetails(id)
                    .trackActivity(loadingIndicator)
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

        self.revenue = movieDetails
            .filter{ $0.revenue > 0}
            .map{String($0.revenue).toCurrencyFormat()}
            .asDriver(onErrorJustReturn: "")

        self.budget = movieDetails
            .filter{ $0.budget > 0}
            .map{String($0.budget).toCurrencyFormat()}
            .asDriver(onErrorJustReturn: "")

        self.error  = result
            .errors()
            .map { $0 as? MoyaError }
            .unwrap()
            .mapError(RequestError.self)

    }

    func getBackdropPathImageUrl() -> URL? {
        guard let path = movie.backdropPath else { return nil}
        return URL(string: (imageBaseURL + path))
    }

    func getPosterImageUrl() -> URL? {
        return URL(string: (posterBaseURL + movie.posterPath))
    }

    func getMovieTitle() -> String {
        return movie.originalTitle
    }

    func getMovieReleaseDate() -> String {
        return movie.releaseDate
    }

    func getMovieOverview() -> String {
        return movie.overview
    }

    func fetchMovieDetails() {
        fetchMovieData.onNext(movie.id)
    }

}


extension String{
    func toCurrencyFormat(_ format: String = "en_US") -> String {
        if let intValue = Int(self){
           let numberFormatter = NumberFormatter()
           numberFormatter.locale = Locale(identifier: format)
            numberFormatter.numberStyle = NumberFormatter.Style.currency
           return numberFormatter.string(from: NSNumber(value: intValue)) ?? ""
      }
    return ""
  }
}
