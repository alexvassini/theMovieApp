//
//  MovieDetailsViewControllerTests.swift
//  TheMovieAppTests
//
//  Created by Alexandre  Vassinievski on 08/12/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//
import XCTest
import RxSwift

@testable import TheMovieApp

class MovieDetailsViewControllerTests: XCTestCase {

    var window: UIWindow!

    override func setUp() {
        self.window = UIWindow()
    }

    override func tearDown() {
        self.window = nil
    }

    func test_isGetMovieDetails_beingInvoked_OneTime() {

        let expectation = self.expectation(description: "getMovieDetails")
        let repository = FeedRepositoryMock()
        let viewModel = MovieDetailsViewModel(movie: MockData.movie,
                                              repository: repository)

        viewModel.director.drive(onNext: { _ in
            expectation.fulfill()
        }).disposed(by: rx.disposeBag)

        viewModel.fetchMovieDetails()
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(repository.getMovieDetailsInvokedCount, 1)
    }

    func test_hasFiltered_AllDirectors_fromResults() {
        let repository = FeedRepositoryMock()
        let viewModel = MovieDetailsViewModel(movie: MockData.movie,
                                              repository: repository)
        viewModel.director.drive(onNext: { directors in
            XCTAssertEqual(directors.count, 2)
        }).disposed(by: rx.disposeBag)

        viewModel.fetchMovieDetails()

    }

    func test_hasFiltered_AllDProducers_fromResults() {
        let repository = FeedRepositoryMock()
        let viewModel = MovieDetailsViewModel(movie: MockData.movie,
                                              repository: repository)
        viewModel.producer.drive(onNext: { producers in
            XCTAssertEqual(producers.count, 2)
        }).disposed(by: rx.disposeBag)

        viewModel.fetchMovieDetails()
    }
}
