//
//  FavoritesVC.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 4.02.2022.
//

import UIKit

class FavoritesVC: UIViewController {
    
    var favorites : [Favorite] = []
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        getFavorites()
    }
    
    private func configureVC(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.rowHeight     = 90
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.frame         = view.bounds
        
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseID)
    }
    
    
    private func getFavorites(){
        
        FavoritesManager.retrieveFavorites {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let favoriteCharacters):
                
                if favoriteCharacters.isEmpty {
                    // empty
                }else {
                    self.favorites = favoriteCharacters
      
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                self.presentAlert(message:error.rawValue, title: "Something went wrong!")
            }
        }
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
        
        FavoritesManager.updateWith(character: character, actionType: .remove) {[weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return}
            
            // if there is an error
            
            self.presentAlert(message: error.rawValue , title: "Unable to remove")
        }
    }
}

