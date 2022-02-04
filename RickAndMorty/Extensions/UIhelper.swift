//
//  UIhelper.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 2.02.2022.
//

import UIKit

enum UIHelper {
    
   static func createFlowLayout(view : UIView) -> UICollectionViewFlowLayout{
        
        let height                      = view.bounds.height
        let width                       = view.bounds.width
        let padding:CGFloat             = 12
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: width - 30, height: height / 6)
        
       flowLayout.scrollDirection = .vertical
       
        return flowLayout
    }
    
}

