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

class FeedView: UIViewController {
    
    let viewModel: FeedViewModel
    let loadingView = LoadingView()
    
    weak var delegate: AppActionable?
    
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: FeedViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: FeedView.self), bundle: nil)
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

extension FeedView {


    func configureViews() {
        
         tableView.register(R.nib.movieTableViewCell)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
       
        self.view.addSubview(self.loadingView)
        self.loadingView.prepareForConstraints()
        self.loadingView.pinEdgesToSuperview()
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        
         //self.viewModel.requestTrigger.onNext( () )
        //self.loadingView.show()
        //Request new data
        // Do your job, when done:
        refreshControl.endRefreshing()
    }
    
    func setupBindings() {
        
        viewModel.isLoading.drive(onNext: { (isLoading) in
            self.loadingAnimation(isLoading)
        }).disposed(by: rx.disposeBag)

        self.viewModel.results
            .drive(tableView.rx
                .items(cellIdentifier: R.reuseIdentifier.movieTableViewCell.identifier,
                       cellType: MovieTableViewCell.self)) { _, movie, cell in
                        cell.bind(movie)
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
