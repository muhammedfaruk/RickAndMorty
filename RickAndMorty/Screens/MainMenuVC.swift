//
//  MainMenu.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 2.02.2022.
//

import UIKit

protocol MainMenuVCOutPut {
    func changeLoading(isLoading: Bool, isLoadMoreCharacter: Bool)
    func saveDatas(characters: [Character])
    func selectedCharacter(character: Character)
    func getError(errorRawValue: String)
}


class MainMenuVC: UIViewController {

    lazy var characterList : [Character] = []
    
    var collectionView : UICollectionView!
        
    var isSearching             : Bool = false
    var isLoadingMoreCharacter  : Bool = false
    var page = 1
    
    lazy var viewModel: CharacterListViewModel = CharacterListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureCollectionView()
        configureSearchController()
        viewModel.setDelegate(output: self)
        viewModel.getCharacters(page: page)
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem   = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(didTapFilterButton))
        navigationItem.leftBarButtonItem    = UIBarButtonItem(title: "Clear Filter", style: .done, target: self, action: #selector(didTapClearButton))
        navigationController?.navigationBar.prefersLargeTitles = true 
    }
    
    @objc func didTapClearButton(){
        characterList.removeAll()
        viewModel.removeAllArrayCharacters()
        viewModel.getCharacters(page: 1)
        page = 1
        collectionView.setContentOffset(CGPoint(x: 0, y:0), animated: true)
    }
    
    @objc func didTapFilterButton(){
        let filterVc = FilterSettingsVC()
        filterVc.delegate = self
        present(filterVc, animated: true)
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(view: self.view))
        view.addSubview(collectionView)
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.reuseID)
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
}


//MARK: Connection to ViewModel
extension MainMenuVC: MainMenuVCOutPut {
        
    func changeLoading(isLoading: Bool, isLoadMoreCharacter: Bool) {
        isLoading ? showLoadingView() : hideLoadingView()
        isLoadingMoreCharacter = isLoadMoreCharacter
    }
    
    
    func saveDatas(characters: [Character]) {
        characterList = characters
        collectionView.reloadData()
    }
    
    
    func selectedCharacter(character: Character) {
        navigationController?.pushViewController(CharacterDetailVC(character: character), animated: true)
    }
    
    
    func getError(errorRawValue: String) {
        presentAlert(message: errorRawValue, title: "Error!")
    }
}


// MARK: UICollectionView Data Settings
extension MainMenuVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.reuseID, for: indexPath) as! CharacterCell
        
        let character = characterList[indexPath.item]
        cell.set(character: character)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        viewModel.selectCharacter(row: indexPath.row)
    }
    
    // go to new page character
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY         = scrollView.contentOffset.y
        let contentHight    = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        guard !self.isSearching else {return} // when we are searching we cannot use pagination
                
        if offsetY > contentHight - height {
            guard !isLoadingMoreCharacter else {return}
            page += 1
            viewModel.getCharacters(page: page)
            print(page)
        }
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
            viewModel.searchCharacters(searchBarText: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        characterList.removeAll()
        viewModel.removeAllArrayCharacters()
        viewModel.getCharacters(page: 1)
        page = 1
        collectionView.setContentOffset(.zero, animated: false)
    }
}

// MARK: Filter Button tapped
extension MainMenuVC : FilterSettingsVCDelegate {
    func didTapSearchButton(gender: String, status: String, species: String) {        
        viewModel.filterCharacter(gender: gender, status: status, species: species)
    }
}
