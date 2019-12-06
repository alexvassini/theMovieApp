//
//  AppCoordinator.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 21/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import Foundation
import UIKit

enum TabBar: AppAction {
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
            UIView.transition(with: self.window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.window.rootViewController = newValue
            }, completion: nil)
        }
    }
    
    func start() {
        setupInitialViewController()
    }

    internal func setupInitialViewController() {

        let homeView = UINavigationController(rootViewController: FeedViewController(delegate: self))
        homeView.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)

        let searchView = UINavigationController(rootViewController: FeedViewController(delegate: self))
        searchView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)

        tabBarController.setViewControllers([homeView, searchView], animated: true)

        currentView = tabBarController

    }
    
//    fileprivate func showFeed(){
//        let homeView = FeedViewController()
//        self.navigationController.setViewControllers([homeView], animated: false)
//        homeView.delegate = self
//        self.currentView = navigationController
//    }
    
    fileprivate func showMovieDetails(_ movie: Movie){
        let view = MovieDetailsView(movie: movie)
        view.delegate = self
        present(view)
    }

    internal func present(_ controller: UIViewController) {
        tabBarController.present(controller, animated: true, completion: nil)
    }

}

extension TabBarCoordinator: AppActionable {

    func handle(sender: UIViewController, _ action: AppAction) {
        switch action {

        case TabBar.showMovieDetails(let movie):
            showMovieDetails(movie)

        default:
            break
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


