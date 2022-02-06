//
//  FavoritesVC.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 4.02.2022.
//

import UIKit

protocol FavoritesVCOutPut {
    func saveDatas(favoriteList: [Favorite])
}

class FavoritesVC: UIViewController {
    
    var tableView = UITableView()
    
    lazy var viewModel  : FavoriteViewModel = FavoriteViewModel()
    var favorites       : [Favorite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        viewModel.setDelegate(output: self)
        viewModel.getFavorites()
    }
    
    private func configureVC(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavorites()
    }
    
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.rowHeight     = 90
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.frame         = view.bounds
        
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseID)
    }
}

// MARK: Connect ViewModel
extension FavoritesVC : FavoritesVCOutPut {
    
    func saveDatas(favoriteList: [Favorite]) {
        favorites = favoriteList
        tableView.reloadData()
    }
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseID, for: indexPath) as! FavoritesCell
        let favoritedCharacter = favorites[indexPath.row]
        cell.set(character: favoritedCharacter)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let character = favorites[indexPath.row]
        
        viewModel.removeFavoriteChar(chracter: character, indexPath:indexPath)
    }
}

