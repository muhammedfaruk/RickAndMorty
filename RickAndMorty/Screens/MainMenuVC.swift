//
//  MainMenu.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 2.02.2022.
//

import UIKit
import SkeletonView


class MainMenuVC: UIViewController {
    
    lazy var characterList  = [Character]()
    
    var collectionView : UICollectionView!
    let reuseIdentifier = "characterCell"
    
    var isSearching : Bool = false
    var isLoadingMoreCharacter : Bool = false
    var showSkeleton: Bool = true
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureCollectionView()
        configureSearchController()
        getCharacters(pageNumber: page)
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem   = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(didTapFilterButton))
        navigationItem.leftBarButtonItem    = UIBarButtonItem(title: "Clear Filter", style: .done, target: self, action: #selector(didTapClearButton))
        navigationController?.navigationBar.prefersLargeTitles = true 
    }
    
    @objc func didTapClearButton(){
        characterList.removeAll()
        getCharacters(pageNumber: 1)
    }
    
    @objc func didTapFilterButton(){
        let filterVc = FilterSettingsVC()
        filterVc.delegate = self
        present(filterVc, animated: true)
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(view: self.view))
        view.addSubview(collectionView)
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate     = self
        collectionView.dataSource   = self
    }
    
    func configureSearchController(){
        let searchController                         = UISearchController()
        searchController.searchBar.placeholder       = "Please enter a username"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate          = self
        navigationItem.searchController              = searchController
    }
    
    
    // MARK: Get Data From Network
    private func getCharacters(pageNumber : Int) {
        
        showSkeleton ? showSkeleton(uıView: collectionView) : showLoadingView()
        isLoadingMoreCharacter = true
        NetworkManager.shared.getCharacters(type: .characters, page: page) {[weak self] characterList, error in
            guard let self = self else {return}
            self.showSkeleton ? self.hideSkeleton(uıView: self.view) : self.hideLoadingView()
            
            guard error == nil else {
                //Internet connection error
                self.presentAlert(message: "Please check your network connection!", title: "No Connection")
                return
            }
            
            guard let characterList = characterList else {return}
            
            self.characterList.append(contentsOf: characterList.results)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            self.isLoadingMoreCharacter = false
        }
    }
    
    private func searchCharacters(searchBarText: String) {
        showSkeleton(uıView: collectionView)
        NetworkManager.shared.searchCharacters(name: searchBarText) {[weak self] characterList, error in
            guard let self = self else {return}
            self.hideSkeleton(uıView: self.collectionView)
            guard error == nil else {
                //when user enter wrong name or wrong words
                self.presentAlert(message: "Please check your name!", title: "Wrong name")
                return
            }
            guard let characterList  = characterList else {return}
            self.characterList       = characterList.results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}


// MARK: UICollectionView Data Settings

extension MainMenuVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharacterCell
        
        let character = characterList[indexPath.item]
        cell.set(character: character)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailVC = CharacterDetailVC(character: characterList[indexPath.item])        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // go to new page character
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY         = scrollView.contentOffset.y
        let contentHight    = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        guard !self.isSearching else {return} // when we are searching we cannot use pagination
                
        if offsetY > contentHight - height {
            guard !isLoadingMoreCharacter else {return}
            showSkeleton = false
            page += 1
            getCharacters(pageNumber: self.page)
        }
    }
}

// MARK: Skeleton View Settings
extension MainMenuVC: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return reuseIdentifier
    }
}

// MARK: Search bar settings
extension MainMenuVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty {
            let searchText = searchBar.text!.lowercased()
            characterList.removeAll()
            searchCharacters(searchBarText: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        characterList.removeAll()
        getCharacters(pageNumber: page)
    }
}

// when user tapped filter search button here will work
extension MainMenuVC : FilterSettingsVCDelegate {
    
    func didTapSearchButton(gender: String, status: String, species: String) {
        showLoadingView()
        NetworkManager.shared.filterCharacters(status: status, gender: gender, species: species) { [weak self] characterList, error in
            guard let self = self else {return}
            self.hideLoadingView()
            guard error == nil else {
                //Internet connection error
                self.presentAlert(message: "Please check your network connection!", title: "No Connection")
                return
            }
            
            guard let characterList = characterList else {return}
            
            self.characterList = characterList.results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            } 
        }
    }
}
