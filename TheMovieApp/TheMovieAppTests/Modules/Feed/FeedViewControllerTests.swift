//
//  FeedViewControllerTests.swift
//  TheMovieAppTests
//
//  Created by Alexandre  Vassinievski on 08/12/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import XCTest
import RxSwift

@testable import TheMovieApp

class FeedViewControllerTests: XCTestCase {

    var window: UIWindow!

    override func setUp() {
        self.window = UIWindow()
    }

    override func tearDown() {
        self.window = nil
    }

    func test_should_showLoadingView_called() {

        let expectation = self.expectation(description: "loading")

        let loadingViewSpy = LoadingViewSpy()
        let viewModel = FeedViewModelSpy()
        let view = FeedViewController(viewModel: viewModel)

        view.loadingView = loadingViewSpy
        loadView(window: window, viewController: view)

        loadingViewSpy.showLoadingHandler = {
            expectation.fulfill()
        }

        viewModel.isLoadingSubject.onNext(true)

        wait(for: [expectation], timeout: 1)

        XCTAssertTrue(loadingViewSpy.showLoadingCalled)
    }

    func test_should_hideLoadingView_called() {
        let expectation = self.expectation(description: "loading")

        let loadingViewSpy = LoadingViewSpy()
        let viewModel = FeedViewModelSpy()
        let view = FeedViewController(viewModel: viewModel)

        view.loadingView = loadingViewSpy
        loadView(window: window, viewController: view)

        loadingViewSpy.showLoadingHandler = {
            expectation.fulfill()
        }

        viewModel.isLoadingSubject.onNext(false)

        wait(for: [expectation], timeout: 1)

        XCTAssertFalse(loadingViewSpy.showLoadingCalled)
        XCTAssertTrue(loadingViewSpy.hideLoadingCalled)

    }

    func test_setupBindings_should_call_requesterTrigger () {
        let expectation = self.expectation(description: "request Trigger")
        let viewModel = FeedViewModelSpy()
        let view = FeedViewController(viewModel: viewModel)

        viewModel.requestTriggerHandler = {
                   expectation.fulfill()
               }

        loadView(window: window, viewController: view)

        wait(for: [expectation], timeout: 1)

        XCTAssertTrue(viewModel.requestTriggerCalled)

    }

    class FeedViewModelSpy: FeedViewModel {

        let isLoadingSubject = PublishSubject<Bool>()
        var requestTriggerCalled = false
        var requestTriggerCalledCount = 0
        var requestTriggerHandler: (()->Void)?

        override init(repository: FeedRepository = FeedRepositoryMock()) {
            super.init()

            isLoading = isLoadingSubject.asDriver(onErrorJustReturn: false)

            _ = requestTrigger.bind { _ in
                self.requestTriggerCalledCount += 1
                self.requestTriggerCalled = true
                self.requestTriggerHandler?()
            }
        }
    }

    class LoadingViewSpy: LoadingView {

        var showLoadingCalled = false
        var hideLoadingCalled = false

        var showLoadingHandler: (()->Void)?

        override func show() {
            showLoadingCalled = true
            showLoadingHandler?()
        }

        override func hide() {
            hideLoadingCalled = true
            showLoadingHandler?()
        }
    }
}
