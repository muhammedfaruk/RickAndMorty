//
//  ViewController+Ext.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 3.02.2022.
//

import UIKit


extension UIViewController {
    
    func presentAlert(message: String, title: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
    }
    
    // MARK: Skeleton view show and hide
    
    func showSkeleton(uıView: UIView) {
        uıView.isSkeletonable = true
        uıView.showAnimatedSkeleton(usingColor: .carrot, transition: .crossDissolve(0.25))
    }
    
    func hideSkeleton(uıView:UIView){
        uıView.stopSkeletonAnimation()
        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
}
