//
//  FavoritesCell.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 4.02.2022.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    static var reuseID = "favoriteCell"

    let charImage   = MyCustomImage(frame: .zero)
    let nameLabel   = MyCustomLabel(textAlignment: .left, fontSize: 26, weight: .bold)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func set(character: Favorite){
        nameLabel.text = character.name
        charImage.downloadImage(url: character.image)
    }
       
    
    
    private func configure() {
        addSubview(charImage)
        addSubview(nameLabel)
        
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            charImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            charImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            charImage.widthAnchor.constraint(equalToConstant: 70),
            charImage.heightAnchor.constraint(equalToConstant: 70),
            
            nameLabel.centerYAnchor.constraint(equalTo: charImage.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: charImage.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }

}
