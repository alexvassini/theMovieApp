//
//  AppCoordinator.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 21/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import Foundation
import UIKit

enum AppAction {
    
    case showMovieDetails(_ movie: Movie)
    
}

protocol AppActionable: class {
    func handle(_ action: AppAction)
}

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    let window: UIWindow
    var navigationController: UINavigationController
    // MARK: - Coordinator
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
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
        let homeView = FeedView()
        self.navigationController.setViewControllers([homeView], animated: false)
        homeView.delegate = self
        self.currentView = navigationController
    }
    
    fileprivate func showMovieDetails(_ movie: Movie){
        let view = MovieDetailsView(movie: movie)
        view.delegate = self
        //view.movie = movie
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
