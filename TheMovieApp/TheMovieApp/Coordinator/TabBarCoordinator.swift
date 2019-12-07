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

class TabBarCoordinator: Coordinator {
    
    // MARK: - Properties
    private let window: UIWindow
    private let tabBarController: UITabBarController

    // MARK: - Coordinator
    init(window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController()
    }
    
    var currentView: UIViewController? {
        get {
            return window.rootViewController
        }
        set {
            UIView.transition(with: self.window, duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.window.rootViewController = newValue
            }, completion: nil)
        }
    }
    
    func start() {
        setupInitialViewController()
    }

    internal func setupInitialViewController() {

        // Home View
        let homeView = UINavigationController(rootViewController: FeedViewController(delegate: self))
        homeView.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)

        // Search  View
        let searchView = UINavigationController(rootViewController: SearchViewController(delegate: self))
        searchView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)

        tabBarController.setViewControllers([homeView, searchView], animated: true)
        currentView = tabBarController

    }
    
    fileprivate func showMovieDetails(_ sender: UIViewController, movie: Movie){
        let view = MovieDetailsViewController(movie: movie, delegate: self)
        sender.navigationController?.pushViewController(view, animated: true)
       // sender.present(view, animated: true, completion: nil)
        //present(view)
    }

    internal func present(_ controller: UIViewController) {
        controller.modalPresentationStyle = .fullScreen
        tabBarController.present(controller, animated: true, completion: nil)
    }

}

extension TabBarCoordinator: AppActionable {

    func handle(sender: UIViewController, _ action: AppAction) {
        switch action {

        case .showMovieDetails(let movie):
            showMovieDetails(sender, movie: movie)

        }
    }
}
