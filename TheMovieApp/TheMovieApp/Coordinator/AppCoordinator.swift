//
//  AppCoordinator.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 21/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import Foundation
import Swinject

enum AppAction {
    
    case showMovieDetails(_ movie: Movie)
    
}

protocol AppActionable: class {
    func handle(_ action: AppAction)
}

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    let window: UIWindow
    let container: Container
    var navigationController: UINavigationController
    // MARK: - Coordinator
    init(window: UIWindow, container: Container) {
        self.window = window
        self.container = container
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.backItem?.title = ""
    }
    
    var currentView: UIViewController? {
        get {
            return window.rootViewController
        }
        set {
            UIView.transition(with: self.window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.window.rootViewController = newValue
            }, completion: nil)
        }
    }
    
    func start() {
        showFeed()
        
    }
    
    fileprivate func showFeed(){
        let homeView = container.resolve(FeedView.self)!
        self.navigationController.setViewControllers([homeView], animated: false)
        homeView.delegate = self
        self.currentView = navigationController
    }
    
    fileprivate func showMovieDetails(_ movie: Movie){
        let view = container.resolve(MovieDetailsView.self)!
        view.delegate = self
        view.movie = movie
        self.navigationController.pushViewController(view, animated: true)
    }

}

extension AppCoordinator: AppActionable {
    
    func handle(_ action: AppAction) {
        
        switch action {
            
        case .showMovieDetails(let movie):
            showMovieDetails(movie)
            
        }
    }
    
}
