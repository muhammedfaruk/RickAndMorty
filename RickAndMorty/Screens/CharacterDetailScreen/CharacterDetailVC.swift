//
//  CharacterDetailVC.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 4.02.2022.
//

import UIKit

class CharacterDetailVC: UIViewController {

    var character : Character!
    
    var favoriteList : [Favorite] = []
    
    let characterImage  = MyCustomImage(frame: .zero)
    let nameLabel       = MyCustomLabel(textAlignment: .center, fontSize: 26, weight: .bold)
    let statusLabel     = MyCustomLabel(textAlignment: .center, fontSize: 24, weight: .regular)
    let genderLabel     = MyCustomLabel(textAlignment: .left, fontSize: 15, weight: .regular)
    let originLabel     = MyCustomLabel(textAlignment: .center, fontSize: 24, weight: .regular)
    let locationLabel   = MyCustomLabel(textAlignment: .center, fontSize: 24, weight: .regular)
    let favoriteButton  = MyCustomButton(title: "Add Favorite List")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureItems()
        configureLayout()
    }
    
    init(character : Character) {
        super.init(nibName: nil, bundle: nil)
        self.character   = character        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureItems(){
        nameLabel.text      = character.name
        statusLabel.text    = "\(character.gender) - \(character.status)"
        originLabel.text    = "Origin:\n\(character.origin.name)"
        locationLabel.text  = "Location:\n\(character.location.name)"
        
        characterImage.downloadImage(url: character.image)
    }
        
    
    @objc func didTapFavoriteButton(){
        let character = Favorite(name: character.name, image: character.image)
        
        FavoritesManager.updateWith(character: character, actionType: .add) { error in
            guard let error = error else {
                self.presentAlert(message: "Sucessfully favorited this user 🥳", title: "Success")
                return
            }                
            self.presentAlert(message: error.rawValue, title: "Success")
        }
    }
}


//MARK: Design
extension CharacterDetailVC {
    private func configureLayout(){
        view.addSubviews(views: characterImage,nameLabel,statusLabel,genderLabel,originLabel,locationLabel,favoriteButton)

        originLabel.layer.borderColor       = UIColor.carrot.cgColor
        originLabel.layer.borderWidth       = 2
        originLabel.layer.cornerRadius      = 5
        
        locationLabel.layer.borderColor     = UIColor.carrot.cgColor
        locationLabel.layer.borderWidth     = 2
        locationLabel.layer.cornerRadius    = 5
                
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            characterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImage.heightAnchor.constraint(equalToConstant: 250),
            characterImage.widthAnchor.constraint(equalToConstant: 250),
            
            nameLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant:10),
            nameLabel.centerXAnchor.constraint(equalTo: characterImage.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant:10),
            statusLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            statusLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            
            originLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 20),
            originLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            originLabel.widthAnchor.constraint(equalToConstant: 140),
            originLabel.heightAnchor.constraint(equalToConstant: 160),
            
            locationLabel.topAnchor.constraint(equalTo: originLabel.topAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            locationLabel.widthAnchor.constraint(equalToConstant: 140),
            locationLabel.heightAnchor.constraint(equalToConstant: 160),
            
            
            favoriteButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20),
            favoriteButton.centerXAnchor.constraint(equalTo: characterImage.centerXAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 150),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
}
