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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    let viewModel: MovieDetailsViewModel!
    var movie: Movie!
    
    var headerHeight: CGFloat = 200.0
    var headerMultiplier: CGFloat = 0.2
    
    weak var delegate: AppActionable?

    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: MovieDetailsView.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupParalaxHeader()
        self.configureViews()
        self.setupBindings()
    }
    
}

extension MovieDetailsView {
    
    func setupParalaxHeader() {
        scrollView.delegate = self
        headerHeight = self.headerHeightConstraint.constant
        scrollView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        scrollView.contentOffset.y = -(headerHeight)
    }
    
    
    func configureViews() {
        
        if let backdropPathUrl = URL(string: (imageBaseURL + movie.backdropPath)){
            backdropPathImage.af_setImage(withURL: backdropPathUrl)
        }
   
        if let posterUrl = URL(string: (imageBaseURL + movie.posterPath)){
            posterImage.af_setImage(withURL: posterUrl)
        }
        
        movieNameLabel.text = movie.originalTitle
        releaseDateLabel.text = movie.releaseDate
  
    }
    
    func setupBindings() {

    }
}

extension MovieDetailsView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y + headerHeight
        if offset < headerHeight {
            headerHeightConstraint.constant = headerHeight - offset
//            titleBar.alpha = offset / (headerHeight - titleBar.frame.height)
//            imageTitleBar.alpha = 1 - offset / (headerHeight - titleBar.frame.height)
        }
        self.view.layoutIfNeeded()
    }
}
