//
//  MyCustomStackView.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 3.02.2022.
//

import UIKit

class MyCustomStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        axis            = .horizontal
        distribution    = .fillEqually
        translatesAutoresizingMaskIntoConstraints = false
    }

}
