//
//  FeedViewModelTests.swift
//  TheMovieAppTests
//
//  Created by Alexandre  Vassinievski on 08/12/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//
import XCTest
import RxSwift

@testable import TheMovieApp

class FeedViewModelTests: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {

    }

    func test_should_searchRepositories_called() {
        //Given
        let repository = FeedRepositoryMock()
        let viewModel = FeedViewModel(repository: repository)
        //When
        viewModel.results.drive().disposed(by: rx.disposeBag)
        viewModel.requestTrigger.onNext(())
        //Then
        XCTAssertTrue(repository.getMovieListInvokedCount > 0)

    }

    func test_isSearchRepositories_result_starts_empty() {
        //Given
        let repository = FeedRepositoryMock()
        let viewModel = FeedViewModel(repository: repository)
        //When
        viewModel.results.drive(onNext: { (list) in
            XCTAssertTrue(list.isEmpty)
        }).disposed(by: rx.disposeBag)
    }

    func test_isSearchRepositories_is_not_empty() {
        //Given
        let repository = FeedRepositoryMock()
        let viewModel = FeedViewModel(repository: repository)
        //When
        viewModel.results.skip(1).drive(onNext: { (list) in
            XCTAssertFalse(list.isEmpty)
        }).disposed(by: rx.disposeBag)
    }

}
