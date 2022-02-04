//
//  MyCustomButton.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 3.02.2022.
//

import UIKit

class MyCustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title:String) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
    }
    
    private func configure(){
        layer.cornerRadius      = 10
        backgroundColor         = .systemOrange
        titleLabel?.textColor   = .white
        titleLabel?.sizeToFit()
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
