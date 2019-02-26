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
    var navigationController: CustomNavigation
    // MARK: - Coordinator
    init(window: UIWindow) {
        self.window = window
        self.navigationController = CustomNavigation()
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


class CustomNavigation: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    func setupViews() {
        self.navigationBar.barTintColor = UIColor(hexString: "101031")
        self.navigationBar.tintColor = UIColor(hexString: "E6E6E6")
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor(hexString: "E6E6E6")
        ]
    }
}
    

