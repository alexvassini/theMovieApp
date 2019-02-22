//
//  DefaultContainer.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 21/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import Foundation
import Swinject

final class DefaultContainer {
    
    let container: Container
    
    init() {
        self.container = Container()
        self.registerServices()
        self.registerViews()
        self.registerViewModels()
        self.registerStorage()
        self.registerRepositories()
    }
}


//Register Views
extension DefaultContainer {
    func registerViews() {
        self.container.register(FeedView.self) { r in
            FeedView(viewModel: r.resolve(FeedViewModel.self)!)
        }
        
    }
}

//Register ViewModels
extension DefaultContainer {
    func registerViewModels() {
        self.container.register(FeedViewModel.self) { r in
            FeedViewModel()
        }
    }
}

//Register Repositories
extension DefaultContainer {
    func registerRepositories() {
        
    }
}

//Register Services
extension DefaultContainer {
    func registerServices() {
        
    }
}

//Register Storage
extension DefaultContainer {
    func registerStorage() {
        
    }
}


