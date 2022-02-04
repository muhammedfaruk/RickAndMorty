//
//  FavoritesManager.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 4.02.2022.
//
import UIKit

enum SaveActionType{
    case add,remove
}

enum FavoritesManager{
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let character = "character"
    }
    
    //MARK: These functions save and remove data from userdefault.
    
    
    static func updateWith(character: Favorite, actionType:SaveActionType, completed: @escaping (ErrorMessages?)->Void){
        
        retrieveFavorites { result in
            
            switch result{
            case .success(var characters):
                
                switch actionType {
                case .add:
                    
                    guard !characters.contains(character) else{
                        
                        completed(.alreadyInFavorite)
                        return
                    }
                    
                    characters.append(character)
                    
                case .remove:
                    characters.removeAll { $0.name == character.name }
                }
                
                completed(save(favorites: characters))
                
            case .failure(let error):
                completed(error)
            }
            
        }
        
    }
    
    
    static func save(favorites : [Favorite]) -> ErrorMessages? {
        
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.character)
            return nil
        }catch{
            return .unableToFavorite
        }
    }
    
    
    static func retrieveFavorites (completed: @escaping (Result<[Favorite], ErrorMessages>) -> Void) {
        
        guard let favoritesData = defaults.object(forKey: Keys.character) as? Data else {
            // if there is no any data will pass empty array
            completed(.success([]))
            return
        }
        
        
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Favorite].self, from: favoritesData)
            completed(.success(favorites))
        }catch{
            completed(.failure(.unableToFavorite))
        }
    }
}


