//
//  TheMovieAppTests.swift
//  TheMovieAppTests
//
//  Created by Alexandre Vassinievski Ribeiro on 20/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import XCTest
import RxSwift
import Nimble
@testable import TheMovieApp

class TheMovieAppTests: XCTestCase {
    
    var repository: FeedRepositoryMock!
    var viewModel: MovieDetailsViewModel!
    
    var disposeBag: DisposeBag!

    override func setUp() {
        repository = FeedRepositoryMock()
        viewModel = MovieDetailsViewModel(repository: repository)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        repository = nil
        viewModel = nil
        disposeBag = nil
    }

    func test_isGetMovieDetails_beingInvoked_OneTime() {
        
        viewModel.reviews.drive(onNext: { _ in
            
        }).disposed(by: self.disposeBag)
        
        viewModel.director.drive(onNext: { _ in
            
        }).disposed(by: self.disposeBag)
        
        viewModel.movie.onNext(MockData.movie)
        
        expect(self.repository.getMovieDetailsInvokedCount).toEventually(be(1))
        
    }
    
    func test_hasFiltered_AllDirectors_fromResults() {
       
        viewModel.director.drive(onNext: { directors in
            expect(directors).to(haveCount(2))
        }).disposed(by: self.disposeBag)
        
        viewModel.movie.onNext(MockData.movie)
    }
    
    func test_hasFiltered_AllDProducers_fromResults() {
        
        viewModel.producer.drive(onNext: { producers in
            expect(producers).to(haveCount(2))
        }).disposed(by: self.disposeBag)
        
        viewModel.movie.onNext(MockData.movie)
    }
    
    func test_isGetMovieDetails_returnError() {

        repository.getMovieDetailsSuccess = false
        
        viewModel.error.subscribe(onNext: { (error) in
            expect(error).notTo(beNil())
        }).disposed(by: self.disposeBag)
        
    }
    
    


}
