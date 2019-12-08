//
//  SearchViewController.swift
//  TheMovieApp
//
//  Created by Alexandre  Vassinievski on 07/12/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

    let viewModel: SearchViewModel

    let tableView = UITableView()

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        return searchBar
    }()

    let loadingView = LoadingView()

    weak var delegate: AppActionable?

    init(delegate: AppActionable? = nil) {
        self.viewModel = SearchViewModel()
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupBindings()
    }

}

extension SearchViewController {

    func configureViews() {

        tableView.register(R.nib.movieTableViewCell)
        self.navigationItem.title = "🎬 Search 🎬"

        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        self.view.addSubview(loadingView)

        // MARK: - Setup constraints
        view.subviews.forEach {$0.prepareForConstraints()}

        loadingView.pinEdgesToSuperview()

        searchBar.pinSafeTop()
        searchBar.pinLeft()
        searchBar.pinRight()

        tableView.pinTop(0, target: searchBar)
        tableView.pinLeft()
        tableView.pinRight()
        tableView.pinBottom()

    }

    func setupBindings() {

        viewModel.isLoading.drive(onNext: { [weak self] (isLoading) in
            self?.loadingAnimation(isLoading)
        }).disposed(by: rx.disposeBag)

        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter{!$0.isEmpty}
            .subscribe(onNext: { [weak self] query in
                self?.viewModel.doSomething(query: query)
            }).disposed(by: rx.disposeBag)

        searchBar.rx.searchButtonClicked
            .bind { self.searchBar.resignFirstResponder() }
            .disposed(by: rx.disposeBag)

        self.viewModel.results
            .drive(tableView.rx
                .items(cellIdentifier: R.reuseIdentifier.movieTableViewCell.identifier,
                       cellType: MovieTableViewCell.self)) { [weak self] _ , movie, cell in
//                        guard let self = self else { return }
                        cell.bind(MovieTableViewCellViewModel(movie: movie))
//                        if self.tableView.isNearBottomEdge(edgeOffset: 20) {
//                            // self.viewModel.requestTrigger.onNext(())
//                        }
        }.disposed(by: rx.disposeBag)

        self.tableView.rx
            .modelSelected(Movie.self)
            .subscribe(onNext: { [unowned self ] (movie) in
                self.delegate?.handle(sender: self, .showMovieDetails(movie))
            }).disposed(by: rx.disposeBag)

    }

    func loadingAnimation(_ isLoading: Bool){
        DispatchQueue.main.async {
            isLoading ? self.loadingView.show() : self.loadingView.hide()
        }
    }
}
