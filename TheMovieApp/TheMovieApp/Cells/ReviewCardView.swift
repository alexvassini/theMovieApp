//
//  ReviewCardView.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 23/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import UIKit


@IBDesignable class ReviewCardView: UIView {
    
    @IBOutlet weak var reviewAuthorLabel: UILabel!
    
    @IBOutlet weak var reviewContentLabel: UILabel!
    
    let review: Review
    
    init(_ review: Review) {
        self.review = review
        super.init(frame: CGRect.zero)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ReviewCardView {
    
    fileprivate func xibSetup() {
        let IBView = instanceFromNib()
        IBView.frame = bounds
        IBView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(IBView)
        setupUI()
    }
    
    func instanceFromNib() -> UIView {
        let nibView = UINib(nibName: R.nib.reviewCardView.name, bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil)[0] as! UIView
        return nibView
    }
    
    fileprivate func setupUI(){
       
        reviewAuthorLabel.text = self.review.author
        reviewContentLabel.text = self.review.content
    
    }
}



