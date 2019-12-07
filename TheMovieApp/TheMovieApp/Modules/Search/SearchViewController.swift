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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViews()
        setupBindings()
    }

}

extension SearchViewController {

    func configureViews() {

        searchBar.delegate = self
        self.navigationItem.title = "🎬 Search 🎬"

       // view.addSubview(tableView)
        self.view.addSubview(searchBar)
        self.view.addSubview(loadingView)

        // MARK: - Setup constraints
        view.subviews.forEach {$0.prepareForConstraints()}

        loadingView.pinEdgesToSuperview()

        searchBar.pinSafeTop()
        searchBar.pinLeft()
        searchBar.pinRight()

    }

    func setupBindings() {

        viewModel.isLoading.drive(onNext: { [weak self] (isLoading) in
            self?.loadingAnimation(isLoading)
        }).disposed(by: rx.disposeBag)

    }

    func loadingAnimation(_ isLoading: Bool){
        DispatchQueue.main.async {
            isLoading ? self.loadingView.show() : self.loadingView.hide()
        }
    }
}


extension SearchViewController: UISearchBarDelegate {

}

