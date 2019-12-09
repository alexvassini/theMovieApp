//
//  Coordinator.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 21/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start()
}

protocol NavigationCoordinator: AnyObject {

    var navigation: UINavigationController! { get }
    var delegate: AppActionable? { get set }
    var tabBarIndex: Int { get }

    func start() -> UINavigationController
    func pushViewController(_ viewController: UIViewController)
    func presentNavigationController(_ controller: UINavigationController,
                                     presentationStyle: UIModalPresentationStyle,
                                     animated: Bool)
}

protocol AppActionable: AnyObject {
    func handle(sender: UIViewController, _ action: AppAction)
}
