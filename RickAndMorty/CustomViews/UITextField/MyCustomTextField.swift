//
//  MyCustomTextField.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 3.02.2022.
//

import UIKit

class MyCustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder_: String) {
        self.init(frame: .zero)
        placeholder = placeholder_        
    }
    
    private func configure(){
        layer.cornerRadius  = 10
        clipsToBounds       = true
        layer.borderColor   = UIColor.gray.cgColor
        layer.borderWidth   = 2
        textAlignment       = .center
    }

}
