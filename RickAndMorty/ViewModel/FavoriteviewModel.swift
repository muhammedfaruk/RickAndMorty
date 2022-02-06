//
//  FavoriteviewModel.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 6.02.2022.
//

import Foundation


class FavoriteViewModel{
    
    var favoriteArray : [Favorite] = []
    
    var favoriteOutPut : FavoritesVCOutPut?
    
    func setDelegate(output: FavoritesVCOutPut){
        favoriteOutPut = output
    }
    
    func getFavorites(){
        FavoritesManager.retrieveFavorites {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let favoriteCharacters):
                if favoriteCharacters.isEmpty {
                    // empty
                }else {
                    self.favoriteArray = favoriteCharacters
                    // save
                    self.favoriteOutPut?.saveDatas(favoriteList: self.favoriteArray)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func removeFavoriteChar(chracter : Favorite, indexPath: IndexPath){
        FavoritesManager.updateWith(character: chracter, actionType: .remove) {[weak self] error in
            guard let self = self else {return}
            guard let _ = error else {
                self.favoriteArray.remove(at: indexPath.row)
                self.favoriteOutPut?.saveDatas(favoriteList: self.favoriteArray)
                return
            }
        }
    }
}
