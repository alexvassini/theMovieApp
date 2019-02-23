//
//  DefaultContainer.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 21/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import Foundation
import Moya
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
        
        self.container.register(MovieDetailsView.self) { r in
            MovieDetailsView(viewModel: r.resolve(MovieDetailsViewModel.self)!)
        }
        
    }
}

//Register ViewModels
extension DefaultContainer {
    func registerViewModels() {
        
        self.container.register(FeedViewModel.self) { r in
            FeedViewModel(repository: r.resolve(FeedRepository.self)!)
        }
        
        self.container.register(MovieDetailsViewModel.self) { r in
            MovieDetailsViewModel(repository: r.resolve(FeedRepository.self)!)
        }
        
    }
}

//Register Repositories
extension DefaultContainer {
    func registerRepositories() {
        self.container.register(FeedRepository.self) { r in
            FeedRepositoryImpl(
                service: r.resolve(FeedService.self)!
            )
        }
    }
}

//Register Services
extension DefaultContainer {
    func registerServices() {
        
        self.container.register(FeedService.self){ _ in
            let provider = MoyaProvider<FeedRouter>(plugins: self.getDefaultPlugins())
            return FeedServiceImpl(provider: provider)
        }
    }
    
    func getDefaultPlugins() -> [PluginType] {
        
        return [NetworkLoggerPlugin(verbose: true)]
        
    }
}

//Register Storage
extension DefaultContainer {
    func registerStorage() {
        
    }
}


