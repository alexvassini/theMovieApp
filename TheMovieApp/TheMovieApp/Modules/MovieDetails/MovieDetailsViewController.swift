//
//  MovieDetailsView.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 22/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropPathImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var directorView: UIView!
    @IBOutlet weak var producerView: UIView!
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var producerNameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var revenueView: UIView!
    @IBOutlet weak var budgetView: UIView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    
    private let viewModel: MovieDetailsViewModel

    let loadingView = LoadingView()

    weak var delegate: AppActionable?

    init(movie: Movie,
         delegate: AppActionable? = nil) {
        self.viewModel = MovieDetailsViewModel(movie: movie)
        self.delegate = delegate
        super.init(nibName: String(describing: MovieDetailsViewController.self), bundle: nil)
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

extension MovieDetailsViewController {
    
    func configureViews() {

        if let backdropPathUrl = viewModel.getBackdropPathImageUrl() {
            backdropPathImage.af_setImage(withURL: backdropPathUrl)
        }

        if let posterUrl = viewModel.getPosterImageUrl() {
            posterImage.af_setImage(withURL: posterUrl)
        }
        
        movieNameLabel.text = viewModel.getMovieTitle()
        releaseDateLabel.text = viewModel.getMovieReleaseDate()
        
        overviewLabel.text = viewModel.getMovieOverview()

        self.view.addSubview(loadingView)
        loadingView.prepareForConstraints()
        loadingView.pinEdgesToSuperview()

    }
    
    func setupBindings() {
        
        viewModel.isLoading.drive(onNext: { [weak self] (isLoading) in
            self?.loadingAnimation(isLoading)
        }).disposed(by: rx.disposeBag)

        viewModel.director
            .map{$0.isEmpty}
            .drive(directorView.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        viewModel.director.drive(onNext: { [weak self](directors) in
            self?.directorNameLabel.text = directors.joined(separator: ", ")
        }).disposed(by: rx.disposeBag)
        
        viewModel.producer
            .map{$0.isEmpty}
            .drive(producerView.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        viewModel.producer.drive(onNext: { [weak self] (producers) in
            self?.producerNameLabel.text = producers.joined(separator: ", ")
        }).disposed(by: rx.disposeBag)

        viewModel.budget.drive(onNext: { [weak self] (budget) in
            self?.budgetLabel.text = budget
        }).disposed(by: rx.disposeBag)

        viewModel.revenue.drive(onNext: { [weak self] (revenue) in
            self?.revenueLabel.text = revenue
        }).disposed(by: rx.disposeBag)

        viewModel.budget
            .map{$0.isEmpty}
            .drive(budgetView.rx.isHidden)
            .disposed(by: rx.disposeBag)

        viewModel.revenue
            .map{$0.isEmpty}
            .drive(revenueView.rx.isHidden)
            .disposed(by: rx.disposeBag)

        viewModel.fetchMovieDetails()
    }
    
    func loadingAnimation(_ isLoading: Bool){
        DispatchQueue.main.async {
            isLoading ? self.loadingView.show() : self.loadingView.hide()
        }
    }
}

