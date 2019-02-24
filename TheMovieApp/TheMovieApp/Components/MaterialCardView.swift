//
//  MaterialCardView.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 23/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import Foundation
import UIKit

class MaterialCardView: UIView {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureShadow()
    }
    
    override func prepareForInterfaceBuilder() {
        configureShadow()
    }
    
    func configureShadow() {
        self.layer.cornerRadius = 3.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.shouldRasterize = false
        self.backgroundColor = .white
        self.clipsToBounds = false
    }
    
}
