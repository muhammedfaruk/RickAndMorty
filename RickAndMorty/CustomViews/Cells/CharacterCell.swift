//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 2.02.2022.
//

import UIKit
import SkeletonView

class CharacterCell: UICollectionViewCell {
    
    static let reuseID = "characterCell"
    
    let characterImage  = MyCustomImage(frame: .zero)
    let nameLabel       = MyCustomLabel(textAlignment: .left, fontSize: 26, weight: .bold)
    let statusLabel     = MyCustomLabel(textAlignment: .left, fontSize: 24, weight: .regular)
    let genderLabel     = MyCustomLabel(textAlignment: .left, fontSize: 15, weight: .regular)
    let dateLabel       = MyCustomLabel(textAlignment: .right,fontSize: 15,  weight: .regular)
    let statusView      = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(character: Character) {
        characterImage.downloadImage(url: character.image)
        nameLabel.text      = character.name
        statusLabel.text    = "\(character.status) - \(character.species)"
        genderLabel.text    = "Gender : \(character.gender)"
        dateLabel.text      = convertToMonthYearformat(dateData: character.created) // formatted our date string
        // view color control
        if character.status == "Alive" {
            statusView.backgroundColor  = .systemGreen
        }else if character.status == "unknown" {
            statusView.backgroundColor  = .systemGray
        }
        else {
            statusView.backgroundColor  = .systemRed
        }
    }
    
    
    private func configure() {
        contentView.addSubview(characterImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusView)
        contentView.addSubview(genderLabel)
        contentView.addSubview(dateLabel)
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        
        isSkeletonable                  = true
        characterImage.isSkeletonable   = true
        nameLabel.isSkeletonable        = true
        statusLabel.isSkeletonable      = true
        statusView.isSkeletonable       = true
        genderLabel.isSkeletonable      = true
        dateLabel.isSkeletonable = true
        
        backgroundColor     = .carrot
        layer.cornerRadius  = 15      // it should be same with image corner radius
        clipsToBounds       = true
        
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: topAnchor),
            characterImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            characterImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImage.widthAnchor.constraint(equalToConstant: 150),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor,constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            statusView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 10),
            statusView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusView.widthAnchor.constraint(equalToConstant: 15),
            statusView.heightAnchor.constraint(equalToConstant: 15),
            
            statusLabel.centerYAnchor.constraint(equalTo: statusView.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: statusView.trailingAnchor, constant: 5),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 24),
            
            genderLabel.topAnchor.constraint(equalTo: statusLabel.topAnchor, constant: 35),
            genderLabel.leadingAnchor.constraint(equalTo: statusView.leadingAnchor),
            genderLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            genderLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            dateLabel.widthAnchor.constraint(equalToConstant: 80),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
 
        ])
        // making circle view
        statusView.layer.cornerRadius   = 15 / 2
        statusView.clipsToBounds        = true
    }
    
    
    // get image by network manager
   
    
}
