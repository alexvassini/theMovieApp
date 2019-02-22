//
//  FeedView.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 21/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/*
 Code for dependency injection:
    self.register(FeedView.self) { resolver in
        FeedView()
    }
 */

class FeedView: UIViewController {
    
    let viewModel: FeedViewModel
    
    weak var delegate: AppActionable?

    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: FeedView.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        self.setupViewModel()
        self.setupBindings()
    }
    
}

extension FeedView {
    
    func setupViewModel() {
       
    }
    
    func configureViews() {
        
    }
    
    func setupBindings() {

    }
}
