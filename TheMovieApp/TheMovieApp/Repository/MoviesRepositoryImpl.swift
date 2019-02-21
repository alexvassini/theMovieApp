//
//  MoviesRepositoryImpl.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 20/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class MoviesRepositoryImpl: MoviesRepository {
    
    let service: MoviesService
    
    init(service: MoviesService) {
        self.service = service
    }
    
}
