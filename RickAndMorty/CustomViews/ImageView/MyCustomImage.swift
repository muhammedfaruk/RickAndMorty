//
//  MyCustomImage.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 2.02.2022.
//

import UIKit

class MyCustomImage: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius  = 15
        clipsToBounds       = true        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // get image by network manager
    func downloadImage(url : String) {
        NetworkManager.shared.getImage(fromUrl: url) { dataImage, error in
            
            if let error = error {
                print(error.rawValue)
            }
            
            guard let dataImage = dataImage else {
                print(error?.rawValue ?? "")
                return
            }
            
            self.image = dataImage
        }
    }
}
