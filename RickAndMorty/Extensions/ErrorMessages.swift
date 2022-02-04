//
//  ErrorMessages.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 2.02.2022.
//

enum ErrorMessages: String, Error {
    
    case urlError           = "Invalid url please check url"
    case decodingError      = "There is an error when decodind data"
    case imageError         = "There is an error when downloand image"
    case searchingError     = "There is an error when searching data"
    case unableToFavorite   = "Something went wrong when favorited"
    case alreadyInFavorite  = "This user already added"
}
