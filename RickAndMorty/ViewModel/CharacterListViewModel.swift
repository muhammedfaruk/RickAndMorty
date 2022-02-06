//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 6.02.2022.
//

import Foundation

class CharacterListViewModel {
    
    var mainMenuVCOutPut : MainMenuVCOutPut?        
    
    func setDelegate(output: MainMenuVCOutPut){
        mainMenuVCOutPut = output
    }
    
    private var isLoading               = false
    private var isLoadingMoreCharacter  = false
    
    var characterArray : [Character] = []
    
    func getCharacters(page:Int){
        changeLoading()
        NetworkManager.shared.getCharacters(type: .characters, page: page) {[weak self] characterList, error in
            guard let self = self else {return}
            self.changeLoading()
            
            guard error == nil else{
                self.characterArray.removeAll()
                self.mainMenuVCOutPut?.saveDatas(characters: [])
                self.mainMenuVCOutPut?.getError(errorRawValue: error?.rawValue ?? "Something went wrong")
                return
            }
                        
            if let characterList = characterList {
                self.characterArray.append(contentsOf: characterList.results)
                self.mainMenuVCOutPut?.saveDatas(characters: self.characterArray)
            }
        }
    }

    
    func searchCharacters(searchBarText: String) {
        changeLoading()
        NetworkManager.shared.searchCharacters(name: searchBarText) {[weak self] characterList, error in
            guard let self = self else {return}
            self.changeLoading()
            
            guard error == nil else {
                print(error?.rawValue ?? "")
                self.characterArray.removeAll()
                self.mainMenuVCOutPut?.saveDatas(characters: [])
                self.mainMenuVCOutPut?.getError(errorRawValue: error?.rawValue ?? "Something went wrong")
                return
            }
                                    
            if let searchedCharacter = characterList?.results{
                self.characterArray.removeAll()
                self.characterArray.append(contentsOf: searchedCharacter)
                self.mainMenuVCOutPut?.saveDatas(characters: self.characterArray)
            }
        }
    }
    
    
    func filterCharacter(gender: String, status: String, species: String) {
        changeLoading()
        NetworkManager.shared.filterCharacters(status: status, gender: gender, species: species) { [weak self] characterList, error in
            guard let self = self else {return}
            self.changeLoading()
            guard error == nil else {
                self.characterArray.removeAll()
                self.mainMenuVCOutPut?.saveDatas(characters: [])
                self.mainMenuVCOutPut?.getError(errorRawValue: error?.rawValue ?? "Something went wrong!")
                return
            }
            
            if let filteredCharacter = characterList?.results{
                self.characterArray.removeAll()
                self.characterArray.append(contentsOf: filteredCharacter)
                self.mainMenuVCOutPut?.saveDatas(characters: self.characterArray)
            }
        }
    }
     
        
    func changeLoading () {
        isLoading               = !isLoading
        isLoadingMoreCharacter  = !isLoadingMoreCharacter
        
        mainMenuVCOutPut?.changeLoading(isLoading: isLoading, isLoadMoreCharacter: isLoadingMoreCharacter)
    }
    
    func removeAllArrayCharacters(){
        characterArray.removeAll()
    }
}
