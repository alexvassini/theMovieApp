//
//  SearchViewModel.swift
//  TheMovieApp
//
//  Created by Alexandre  Vassinievski on 07/12/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftExt
import RxSwiftUtilities
import Moya

class SearchViewModel {

    private let repository: FeedRepository

    let isLoading: Driver<Bool>


    init(repository: FeedRepository = FeedRepositoryImpl()) {

        self.repository = repository

        let loadingIndicator = ActivityIndicator()

        self.isLoading = loadingIndicator
            .startWith(false)
            .asDriver()

    }

}

