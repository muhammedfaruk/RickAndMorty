//
//  Character.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 2.02.2022.
//

import Foundation

struct CharacterList: Codable,Hashable {
    let results : [Character]
}

struct Character: Codable, Hashable {
    
    let id      : Int
    let name    : String
    let status  : String
    let species : String
    let type    : String
    let gender  : String
    let origin  : Origin
    let location: Location
    let image   : String
    let episode : [String]
    let url     : String
    let created : String
}

struct Location: Codable,Hashable {
    let name: String
    let url: String
}

struct Origin:Codable,Hashable {
    let name: String
    let url: String
}
