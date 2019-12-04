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

class FeedViewController: UIViewController {
    
    let viewModel: FeedViewModel
    let loadingView = LoadingView()
    
    weak var delegate: AppActionable?
    
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: FeedViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: FeedViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        self.setupBindings()
    }
    
}

extension FeedViewController {


    func configureViews() {
        
        tableView.register(R.nib.movieTableViewCell)
        self.navigationItem.title = "🎬 The Movie App 🎬"
        
        self.view.addSubview(self.loadingView)
        self.loadingView.prepareForConstraints()
        self.loadingView.pinEdgesToSuperview()
    }
    
    func setupBindings() {
        
        viewModel.isLoading.drive(onNext: { (isLoading) in
            self.loadingAnimation(isLoading)
        }).disposed(by: rx.disposeBag)

        self.viewModel.results
            .drive(tableView.rx
                .items(cellIdentifier: R.reuseIdentifier.movieTableViewCell.identifier,
                       cellType: MovieTableViewCell.self)) { [unowned self] _ , movie, cell in
                        cell.bind(movie)
                        if self.tableView.isNearBottomEdge(edgeOffset: 20) {
                            self.viewModel.requestTrigger.onNext(())
                        }
            }.disposed(by: rx.disposeBag)

        self.tableView.rx
            .modelSelected(Movie.self)
            .subscribe(onNext: { [unowned self ] (movie) in
                self.delegate?.handle(.showMovieDetails(movie))
            }).disposed(by: rx.disposeBag)
        
       
        
        self.viewModel.requestTrigger.onNext( () )
        
    }
    
    func loadingAnimation(_ isLoading: Bool){
        DispatchQueue.main.async {
            isLoading ? self.loadingView.show() : self.loadingView.hide()
        }
        
    }
    
}

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
