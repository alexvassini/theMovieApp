//
//  XCTestCase+Extensions.swift
//  TheMovieAppTests
//
//  Created by Alexandre  Vassinievski on 08/12/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//


import Foundation
import UIKit
import XCTest

extension XCTestCase {

    // MARK: Public Methods
    func loadView(window: UIWindow, viewController: UIViewController) {
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
}
