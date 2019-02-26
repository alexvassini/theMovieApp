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

class MovieDetailsView: UIViewController {
    
    @IBOutlet weak var backdropPathImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var directorView: UIView!
    @IBOutlet weak var producerView: UIView!
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var producerNameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var reviewsStackView: UIStackView!
    @IBOutlet weak var reviewScrollView: UIScrollView!
    @IBOutlet weak var reviewContainer: UIView!

    let imageBaseURL = "https://image.tmdb.org/t/p/w1280"
    let posterBaseURL = "https://image.tmdb.org/t/p/w500"
    
    let viewModel: MovieDetailsViewModel!
    let movie: Movie
    
    var headerHeight: CGFloat = 200.0
    var headerMultiplier: CGFloat = 0.2
    
    let loadingView = LoadingView()
    let emptyStateView = EmptyStateView()
    
    weak var delegate: AppActionable?

    init(movie: Movie) {
        self.movie = movie
        self.viewModel = MovieDetailsViewModel()
        super.init(nibName: String(describing: MovieDetailsView.self), bundle: nil)
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

extension MovieDetailsView {
    
    func configureViews() {
        
        if let backdropPathUrl = URL(string: (imageBaseURL + movie.backdropPath)){
            backdropPathImage.af_setImage(withURL: backdropPathUrl)
        }
   
        if let posterUrl = URL(string: (posterBaseURL + movie.posterPath)){
            posterImage.af_setImage(withURL: posterUrl)
        }
        
        movieNameLabel.text = movie.originalTitle
        releaseDateLabel.text = movie.releaseDate
        
        overviewLabel.text = movie.overview
        
        reviewContainer.addSubview(loadingView)
        loadingView.prepareForConstraints()
        loadingView.pinEdgesToSuperview()
        
        reviewContainer.addSubview(emptyStateView)
        emptyStateView.prepareForConstraints()
        emptyStateView.pinEdgesToSuperview()
        
  
    }
    
    func setupBindings() {
        
        viewModel.isLoading.drive(onNext: { (isLoading) in
            self.loadingAnimation(isLoading)
        }).disposed(by: rx.disposeBag)

        viewModel.director
            .map{$0.isEmpty}
            .drive(directorView.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        viewModel.director.drive(onNext: { [unowned self](directors) in
            self.directorNameLabel.text = directors.joined(separator: ", ")
        }).disposed(by: rx.disposeBag)
        
        viewModel.producer
            .map{$0.isEmpty}
            .drive(producerView.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        viewModel.producer.drive(onNext: { [unowned self](producers) in
            self.producerNameLabel.text = producers.joined(separator: ", ")
        }).disposed(by: rx.disposeBag)
        
        
        viewModel.reviews.drive(onNext: { [unowned self] reviews in
            if reviews.isEmpty {
                 DispatchQueue.main.async {
                    self.emptyStateView.show()
                }
            }
            else{self.emptyStateView.hide()}
            self.createReviewCards(reviews)
        }).disposed(by: rx.disposeBag)
        
        viewModel.movie.onNext(self.movie)
    }
    
    func createReviewCards(_ reviews: [Review]){
        for review in reviews {
            let view = ReviewCardView(review)
            self.reviewsStackView.addArrangedSubview(view)
            view.prepareForConstraints()
            view.widthAnchor.constraint(equalTo: reviewScrollView.widthAnchor, multiplier: 0.90).isActive = true
        }
    }
    
    func loadingAnimation(_ isLoading: Bool){
        DispatchQueue.main.async {
             isLoading ? self.loadingView.show() : self.loadingView.hide()
        }
    }
}

