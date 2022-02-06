//
//  ErrorMessages.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 2.02.2022.
//

enum ErrorMessages: String, Error {
    case networkError       = "Please check your network connection!"
    case imageError         = "There is an error when downloand image"
    case searchingError     = "Please check your entered name!"
    case unableToFavorite   = "Something went wrong when favorited"
    case alreadyInFavorite  = "This user already added"
    case filteredError      = "Please check your filters"
}
