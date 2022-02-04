//
//  CustomTabBar.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 2.02.2022.
//

import UIKit

class CustomTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemOrange
        viewControllers = [createMainMenuNC(),createFavoriteVC()]
    }
    
    private func createMainMenuNC() -> UINavigationController{
        let mainMenu = MainMenuVC()        
        mainMenu.title = "Characters"
        mainMenu.tabBarItem   = UITabBarItem(title: "Characters", image: images.menuTabBarImage, tag: 0)
        
        return UINavigationController(rootViewController: mainMenu)
    }
    
    
    private func createFavoriteVC() -> UINavigationController{
        let favoriteVC = FavoritesVC()
        favoriteVC.title = "Favorites"
        favoriteVC.tabBarItem   = UITabBarItem(title: "Favorites", image:images.favoriteTabBarImage, tag: 1)
        
        return UINavigationController(rootViewController: favoriteVC)
    }
        
}
