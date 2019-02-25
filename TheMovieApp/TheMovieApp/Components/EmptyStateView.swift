//
//  EmptyState.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 24/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//


import Foundation
import UIKit
import Lottie

class EmptyStateView: UIView {
    
    private var didSetupViews: Bool = false
    
    var lottieView: LOTAnimationView?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
        self.accessibilityIdentifier = "emptyState_view"
    }
    
    func show() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
        lottieView?.play()
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.0
        }
        lottieView?.stop()
    }
    
    private func setupViews() {
        if !didSetupViews {
            self.didSetupViews = true
            self.setupConstraints()
        }
    }
    
    private func setupConstraints() {
        self.lottieView = LOTAnimationView(name: "empty-box")
        self.addSubview(lottieView!)
        
        lottieView?.alpha = 0.8
        lottieView?.constraintWidth(120.0)
        lottieView?.constraintHeight(120.0)
        lottieView?.prepareForConstraints()
        lottieView?.centerHorizontally()
        lottieView?.centerVertically()
        lottieView?.loopAnimation = true
        
    }
    
}

